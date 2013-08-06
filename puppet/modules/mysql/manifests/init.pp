class mysql {
    $password = ""
    $packages = ["mysql-server", "mysql-client", "libmysqlclient-dev"]
    $db_name = "CTI_db_test"
    #$db_path = "puppet:///modules/mysql/CTI_db_test.sql.gz"

    package { $packages:
        ensure  => present,
        require => Exec['apt-get update'];
    }

    service { "mysql":
        enable => true,
        ensure => running,
        require => Package["mysql-server"],
    }

    file { "/vagrant/CTI_db_test.sql.gz":
        ensure => present,
        source => 'puppet:///modules/mysql/CTI_db_test.sql.gz';
    }

    exec { "set-mysql-password":
        unless => "mysqladmin -uroot -p${password} status",
        command => "mysqladmin -uroot password $password",
        require => Service["mysql"];
    }
    exec { "create-db":
        unless => "/usr/bin/mysql -uroot -p${password} ${db_name}",
        command => "/usr/bin/mysql -uroot -e \"create database ${db_name};\"",
        require => Service["mysql"];
    }

    exec { "grant-db":
        unless => "/usr/bin/mysql -uroot -p${password} ${db_name}",
        #command => "/usr/bin/mysql -uroot -e \"grant all on ${db_name}.* to root@localhost identified by '$password';\"",
        command => "/usr/bin/mysql -uroot -e \"grant all on ${db_name}.* to root@localhost; FLUSH PRIVILEGES;\"",
        require => [Service["mysql"], Exec["create-db"]];
    }
    exec { "import-CTI":
        #unless => "/usr/bin/mysql -uroot -p${password} -e \"use ${db_name}\"",
        require => [Service["mysql"], Exec["grant-db"]],
        command => "/bin/gzip -dc /vagrant/CTI_db_test.sql.gz | /usr/bin/mysql -uroot ${db_name}";
    }
}
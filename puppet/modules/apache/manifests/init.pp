class apache {
    package {
        "apache2":
            ensure  => present,
            require => Exec['apt-get update'],
    }
    
    service {
        "apache2":
            ensure      => running,
            enable      => true,
            require     => Package['apache2'],
            subscribe   => [
                File["/etc/apache2/sites-available/default"]
            ],
    }

    file {
        "/etc/apache2/sites-available/default":
            ensure  => present,
            owner => root,
            group => root,
            content  => template('apache/vhost.erb'),
            require => Package['apache2'],
    }

    exec {
        'echo "ServerName localhost" | sudo tee /etc/apache2/conf.d/fqdn':
            require => Package['apache2'],
    }
}
class taxii {

    file { '/home/www' :
        ensure  => directory,
        group   => root,
        owner   => root,
        mode    => 0755,
    }

    vcsrepo { "/home/www/taxiiservice":
        ensure   => latest,
        owner    => www-data,
        group    => www-data,
        provider => git,
        require => File["/home/www"],
        source   => "https://github.com/MISP/MISP-TAXII.git",
        revision => 'master',
    }

    file {
        "/home/www/taxiiservice/config.py":
            ensure  => present,
            owner => www-data,
            group => www-data,
            content  => template('taxii/config.erb'),
    }
    file {
        "/home/www/taxiiservice/taxii_service.wsgi":
            ensure  => present,
            owner => www-data,
            group => www-data,
            content  => template('taxii/wsgi.erb'),
    }

    exec {
        'pip install -r /home/www/taxiiservice/requirements.txt':
            require => Package['apache2'],
    }
}
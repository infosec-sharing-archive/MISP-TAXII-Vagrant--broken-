class other {
    $packages = [
        "curl", "git", "python-flup", "python-dev", "python-pip",
        "libapache2-mod-wsgi", "libxslt1-dev", "libxml2-dev"
    ]
    
    package {
        $packages:
            ensure  => latest,
            require => Exec['apt-get update']
    }
}
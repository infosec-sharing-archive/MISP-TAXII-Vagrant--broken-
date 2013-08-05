#!/usr/bin/env bash

if puppet module list | grep vcsrepo > /dev/null; then
    echo "Puppet module vcsrepo is already installed"
    exit 0
fi

sudo puppet module install puppetlabs/vcsrepo

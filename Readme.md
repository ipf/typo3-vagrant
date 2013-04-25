# Installation

## Clone this repository

 > git clone git://github.com/ipf/typo3-vagrant.git

## Get all submodules

 > git submodule update --init

# Running

Simply use the "vagrant up" command to start your virtual machine.
In some cases you have to call "vagrant reload" after that to become provisioned with software.

Your machine will be available with a working TYPO3 version at http://localhost:8333

# Passwords

As usual there is a system vagrant user with password "vagrant". The MySQL Installation is done with the root user and the password "typo3"

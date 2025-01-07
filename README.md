Intall and configure Errbit - https://github.com/errbit/errbit on Debian based systems

# REQUIREMENTS:

## Platform:

This cookbook has been customized and tested on the Debian OS family:

* Ubuntu 20.04
* Ubuntu 22.04
* Debian 11
* Debian 12

# DEFINITIONS:

The application is installed using the attributes 

# Attributes
## User
Creation the user under by application will be installed 

* `default['user']['name']` - The user name
* `default['user']['path']` - The user home directory 

> [!NOTE]
> For a created user, we set uid & gid -> 1005 by default, because uid 1000 may be occupied by a user already created in the system
> default['user']['uid'] = '1005'
> default['user']['gid'] = '1005'

## Errbit

* `default['errbit']['destination']` - Specifies the directory to which the Errbit application repository will be cloned.
* `default['errbit']['admin']['name']` - Specifies the default admin username
* `default['errbit']['admin']['email']` - Specifies email that will be used as a login to the Errbit application
* `default['errbit']['admin']['password']` - Specifies password that will be used as a password to the Errbit application
* The user data is passed to the template that will be used later on when installing the Errbit application

## Mongo
`default['mongodb']['package_version']` - Specifies the Mongodb version that will be installed. By default it's v 8.0.0
>[!NOTE]
> On Debian 11 by default will be installed Mongodb v 6.0.0

# Installation

The installation of the Errbit application is divided into the following steps

- Cloning the Errbit application repository
- Downloading Ruby Version Managment and its packages to install ruby
- Installing Ruby 2.7.6 needed to install the Errbit application
- Installing the libv8-node and mini_racer gem packages needed to install the Errbit application
- Installing the Errbit application and starting the rails server

The tasks for installing the Errbit application are in the **errbit_install.rb** recipe

# Templates

There is a template templates/errbit.erb to create a user of the Errbit application.
The data from this template will be placed in the .env file in the errbit repository during installation

# Tests

The kitchen-test functionality was used to test the recipe book.
The tests file is located at test/integration/default/default_test.rb
The tests check for:
- User creation
- Mongodb service
- Errbit service 
- Presence of ruby directory that was created by the rvm application

# Cookbook structure

```
errbit/
├── attributes
│   └── default.rb
├── CHANGELOG.md
├── chefignore
├── compliance
│   ├── inputs
│   ├── profiles
│   ├── README.md
│   └── waivers
├── kitchen.yml
├── LICENSE
├── metadata.rb
├── Policyfile.lock.json
├── Policyfile.rb
├── README.md
├── recipes
│   ├── create_unit.rb
│   ├── create_user.rb
│   ├── default.rb
│   ├── errbit_install.rb
│   ├── install.rb
│   └── mongo_install.rb
├── templates
│   └── errbit.erb
└── test
    └── integration
        └── default
            └── default_test.rb
```

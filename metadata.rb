name 'cerny-loadbalancer'
maintainer 'Nathan Cerny'
maintainer_email 'ncerny@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures cerny-loadbalancer'
long_description 'Installs/Configures cerny-loadbalancer'
version '0.5.5'
chef_version '>= 12.14' if respond_to?(:chef_version)
issues_url 'https://github.com/ncerny/cerny-loadbalancer/issues'
source_url 'https://github.com/ncerny/cerny-loadbalancer'

supports 'debian', '>= 9'

depends 'packagecloud'
depends 'kernel_module'

# == Class: pmlc_neutron::server
#
# Class to setup and manage neutron server
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_neutron::server {

  include ::pmlc_neutron::server::install
  include ::pmlc_neutron::server::config
  include ::pmlc_neutron::server::service

  Class['::pmlc_neutron::server::install'] ->
  Class['::pmlc_neutron::server::config'] ->
  Class['::pmlc_neutron::server::service']
}

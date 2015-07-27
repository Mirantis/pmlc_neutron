# == Class: pmlc_neutron::client
#
# Class to setup and manage neutron client
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_neutron::client {

  include ::pmlc_neutron::client::install
  include ::pmlc_neutron::client::config
  include ::pmlc_neutron::client::service

  Class['::pmlc_neutron::client::install'] ->
  Class['::pmlc_neutron::client::config'] ->
  Class['::pmlc_neutron::client::service']
}

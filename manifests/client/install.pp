# == Class: pmlc_neutron::client::install
#
# Install neutron packages
#
# Scott Brimhall [sbrimhall@mirantis.com]
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_neutron::client::install (
  $use_aci = ::pmlc_neutron::use_aci,
) inherits ::pmlc_neutron {

  $packages = [
    'neutron-common',
    'neutron-dhcp-agent',
    'neutron-l3-agent',
    'neutron-metadata-agent',
    'neutron-plugin-ml2',
    'neutron-plugin-openvswitch-agent',
    'python-neutron',
    'python-neutronclient',
  ]

  package { $packages:
    ensure => 'present',
  }

  if $use_aci == true {
    $aci_packages = [
      'neutron-ml2-driver-apic',
      'python-apicapi',
    ]

    package { $aci_packages:
      ensure => 'present',
    }
  }

}

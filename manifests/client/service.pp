# == Class: pmlc_neutron::client::service
#
# Class to configure neutron services on controller
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_neutron::client::service (
  $use_aci = $::pmlc_neutron::use_aci,
) inherits ::pmlc_neutron {

  $service = $use_aci ? {
    true => [
      'neutron-cisco-apic-host-agent',
      'neutron-plugin-openvswitch-agent',
    ],
    false => [
      'neutron-plugin-openvswitch-agent',
    ]
  }

  $file_lines = [
    'neutron_debug_logging',
    'neutron_core_plugin',
    'neutron_dhcp_lease_duration',
    'neutron_allow_overlapping_ips',
    'neutron_router_scheduler_driver',
    'neutron_dhcp_agents_per_network',
    'neutron_api_workers',
    'neutron_nova_admin_user',
    'neutron_nova_admin_pass',
    'neutron_rabbit_user',
    'neutron_rabbit_password',
    'neutron_rabbit_virtualhost',
    'neutron_root_helper',
    'neutron_admin_password',
    'neutron_admin_user',
    'neutron_database_connection',
  ]

  if $use_aci == true {

    service { $service:
      ensure    => 'running',
      enable    => true,
      require   => [File['ml2_conf_cisco'], File_line[$file_lines]],
      subscribe => [File['ml2_conf_cisco'], File_line[$file_lines]],
    }
  } else {
    service { $service:
      ensure    => 'running',
      enable    => true,
      require   => File_line[$file_lines],
      subscribe => File_line[$file_lines],
    }
  }

}

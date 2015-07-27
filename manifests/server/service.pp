# == Class: pmlc_neutron::server::service
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
class pmlc_neutron::server::service (
  $use_aci = $::pmlc_neutron::use_aci,
) inherits ::pmlc_neutron {

  $service = $use_aci ? {
    false => [
      'neutron-server',
    ],
    true => [
      'neutron-server',
      'neutron-cisco-apic-service-agent',
      'neutron-cisco-apic-host-agent',
    ]
  }

  $file_lines = [
    'neutron_debug_logging',
    'neutron_core_plugin',
    'neutron_service_plugins',
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
    'neutron_notification_driver',
    'neutron_root_helper',
    'neutron_admin_password',
    'neutron_admin_user',
    'neutron_database_connection',
    'neutron_rpc_workers',
    'neutron_apipaste_admin_user',
    'neutron_apipaste_admin_password',
    'neutron_dhcp_debug_logging',
    'neutron_dhcp_enable_isolated_metadata',
    'neutron_dhcp_use_namespaces',
    'neutron_dhcp_enable_metadata_network',
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

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

  $config_settings = $use_aci ? {
    false => [
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
    ],
    true  => [
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
      'apic_hosts',
      'apic_username',
      'apic_password',
      'apic_name_mapping',
      'integrated_topology_service',
      'apic_agent_report_interval',
      'apic_agent_poll_interval',
      'apic_provision_hostlinks',
      'shared_context_name',
      'apic root helper',
      'APIC vpc pairs',
      'APIC provision infra',
      'External EPG',
      'preexisting',
      'APIC system id',
    ]
  }

  service { $service:
    ensure    => 'running',
    enable    => true,
    require   => Ini_setting[$config_settings],
    subscribe => Ini_setting[$config_settings],
  }

}

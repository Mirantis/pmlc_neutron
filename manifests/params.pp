# Params class
class pmlc_neutron::params {

  $is_server = undef

  # General neutron settings
  $debug                    = true
  $management_vip           = undef
  $core_plugin              = 'neutron.plugins.ml2.plugin.Ml2Plugin'
  $api_workers              = 1

  # DHCP and subnet settings
  $dhcp_lease_duration      = 600
  $allow_overlapping_ips    = true
  $router_scheduler_driver  = 'neutron.scheduler.l3_agent_scheduler.ChanceScheduler'
  $dhcp_agents_per_network  = 2

  # Nova settings
  $nova_admin_user          = 'nova'
  $nova_admin_pass          = 'nova'

  # Rabbit settings
  $rabbit_user              = 'nova'
  $rabbit_password          = 'nova'
  $rabbit_virtualhost       = '/'
  $notification_driver      = 'messaging'
  $rpc_workers              = 1

  # Neutron Auth
  $root_helper              = 'sudo neutron-rootwrap /etc/neutron/rootwrap.conf'
  $admin_user               = 'neutron'
  $admin_password           = 'neutron'

  # Database Connection
  $database_user            = 'neutron'
  $database_pass            = 'neutron'

  # ACI related settings
  $use_aci                  = false
  $apic_username            = 'admin'
  $apic_password            = 'admin'
  $apic_name_mapping        = 'use_name'
  $apic_provision_hostlinks = false
  $shared_context_name      = 'net04'
  $apic_root_helper         = 'sudo'
  $apic_provision_infra     = false
  $external_epg             = 'net04-ext'
  $preexisting              = true
  $apic_system_id           = 'openstack'

  # DHCP agent settings
  $enable_isolated_metadata = false
  $enable_metadata_network  = false
  $use_namespaces           = true

  # Service plugin for whether ACI is in use or not
  $service_plugins = $use_aci ? {
    false => 'neutron.services.l3_router.l3_router_plugin.L3RouterPlugin,neutron.services.metering.metering_plugin.MeteringPlugin',
    true  => 'cisco_apic_l3,neutron.services.metering.metering_plugin.MeteringPlugin',
  }

}

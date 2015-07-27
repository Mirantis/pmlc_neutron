# == Class: pmlc_neutron
#
# Class to setup and manage neutron
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_neutron (
  $debug                    = $::pmlc_neutron::params::debug,
  $is_server                = $::pmlc_neutron::params::is_server,
  $management_vip           = $::pmlc_neutron::params::management_vip,
  $core_plugin              = $::pmlc_neutron::params::core_plugin,
  $service_plugins          = $::pmlc_neutron::params::service_plugins,
  $dhcp_lease_duration      = $::pmlc_neutron::params::dhcp_lease_duration,
  $allow_overlapping_ips    = $::pmlc_neutron::params::allow_overlapping_ips,
  $router_scheduler_driver  = $::pmlc_neutron::params::router_scheduler_driver,
  $dhcp_agents_per_network  = $::pmlc_neutron::params::dhcp_agents_per_network,
  $api_workers              = $::pmlc_neutron::params::api_workers,
  $nova_admin_user          = $::pmlc_neutron::params::nova_admin_user,
  $nova_admin_pass          = $::pmlc_neutron::params::nova_admin_pass,
  $rabbit_user              = $::pmlc_neutron::params::rabbit_user,
  $rabbit_password          = $::pmlc_neutron::params::rabbit_password,
  $rabbit_virtualhost       = $::pmlc_neutron::params::rabbit_virtualhost,
  $notification_driver      = $::pmlc_neutron::params::notification_driver,
  $root_helper              = $::pmlc_neutron::params::root_helper,
  $admin_user               = $::pmlc_neutron::params::admin_user,
  $admin_password           = $::pmlc_neutron::params::admin_password,
  $database_user            = $::pmlc_neutron::params::database_user,
  $database_pass            = $::pmlc_neutron::params::database_pass,
  $rpc_workers              = $::pmlc_neutron::params::rpc_workers,
  $use_aci                  = $::pmlc_neutron::params::aci,
  $apic_hosts               = $undef,
  $apic_username            = $::pmlc_neutron::params::apic_username,
  $apic_password            = undef,
  $apic_name_mapping        = $::pmlc_neutron::params::apic_name_mapping,
  $apic_provision_hostlinks = $::pmlc_neutron::params::apic_provision_hostlinks,
  $shared_context_name      = $::pmlc_neutron::params::shared_context_name,
  $apic_root_helper         = $::pmlc_neutron::params::apic_root_helper,
  $apic_vpc_pairs           = undef,
  $apic_provision_infra     = $::pmlc_neutron::params::apic_provision_infra,
  $external_epg             = $::pmlc_neutron::params::external_epg,
  $preexisting              = $::pmlc_neutron::params::preexisting,
  $apic_system_id           = $::pmlc_neutron::params::apic_system_id,
  $enable_isolated_metadata = $::pmlc_neutron::params::enable_isolated_metadata,
  $use_namespaces           = $::pmlc_neutron::params::use_namespaces,
  $enable_metadata_network  = $::pmlc_neutron::params::enable_metadata_network,
) inherits ::pmlc_neutron::params {
  # Include stdlib functions
  include stdlib

  validate_bool($debug)
  validate_bool($is_server)
  validate_string($management_vip)
  validate_string($core_plugin)
  validate_string($service_plugins)
  validate_bool($allow_overlapping_ips)
  validate_string($router_scheduler_driver)
  validate_integer($dhcp_agents_per_network)
  validate_integer($api_workers)
  validate_string($nova_admin_user)
  validate_string($nova_admin_pass)
  validate_string($rabbit_user)
  validate_string($rabbit_password)
  validate_string($rabbit_virtualhost)
  validate_string($notification_driver)
  validate_string($root_helper)
  validate_string($admin_user)
  validate_string($admin_password)
  validate_string($database_user)
  validate_string($database_pass)
  validate_integer($rpc_workers)
  validate_bool($use_aci)

  if $use_aci == true {
    validate_string($apic_hosts)
    validate_string($apic_username)
    validate_string($apic_password)
    validate_string($apic_name_mapping)
    validate_bool($apic_provision_hostlinks)
    validate_string($shared_context_name)
    validate_string($apic_root_helper)
    validate_string($apic_vpc_pairs)
    validate_bool($apic_provision_infra)
    validate_string($external_epg)
    validate_bool($preexisting)
    validate_string($apic_system_id)
    validate_bool($enable_isolated_metadata)
    validate_bool($use_namespaces)
    validate_bool($enable_metadata_network)
  }

  $my_class = $is_server ? {
    true  => '::pmlc_neutron::server',
    false => '::pmlc_neutron::client',
  }

  include $my_class

}

# == Class: pmlc_neutron::server::config
#
# Class to manage neutron configuration file
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_neutron::server::config (
  $debug                    = $::pmlc_neutron::debug,
  $management_vip           = $::pmlc_neutron::management_vip,
  $core_plugin              = $::pmlc_neutron::core_plugin,
  $service_plugins          = $::pmlc_neutron::service_plugins,
  $dhcp_lease_duration      = $::pmlc_neutron::dhcp_lease_duration,
  $allow_overlapping_ips    = $::pmlc_neutron::allow_overlapping_ips,
  $router_scheduler_driver  = $::pmlc_neutron::router_scheduler_driver,
  $dhcp_agents_per_network  = $::pmlc_neutron::dhcp_agents_per_network,
  $api_workers              = $::pmlc_neutron::api_workers,
  $nova_admin_user          = $::pmlc_neutron::nova_admin_user,
  $nova_admin_pass          = $::pmlc_neutron::nova_admin_pass,
  $rabbit_user              = $::pmlc_neutron::rabbit_user,
  $rabbit_password          = $::pmlc_neutron::rabbit_password,
  $rabbit_virtualhost       = $::pmlc_neutron::rabbit_virtualhost,
  $notification_driver      = $::pmlc_neutron::notification_driver,
  $root_helper              = $::pmlc_neutron::root_helper,
  $admin_user               = $::pmlc_neutron::admin_user,
  $admin_password           = $::pmlc_neutron::admin_password,
  $database_user            = $::pmlc_neutron::database_user,
  $database_pass            = $::pmlc_neutron::database_pass,
  $rpc_workers              = $::pmlc_neutron::rpc_workers,
  $use_aci                  = $::pmlc_neutron::aci,
  $apic_hosts               = $::pmlc_neutron::apic_hosts,
  $apic_username            = $::pmlc_neutron::apic_username,
  $apic_password            = $::pmlc_neutron::apic_password,
  $apic_name_mapping        = $::pmlc_neutron::apic_name_mapping,
  $apic_provision_hostlinks = $::pmlc_neutron::apic_provision_hostlinks,
  $shared_context_name      = $::pmlc_neutron::shared_context_name,
  $apic_root_helper         = $::pmlc_neutron::apic_root_helper,
  $apic_vpc_pairs           = $::pmlc_neutron::apic_vlc_pairs,
  $apic_provision_infra     = $::pmlc_neutron::apic_provision_infra,
  $external_epg             = $::pmlc_neutron::external_epg,
  $preexisting              = $::pmlc_neutron::preexisting,
  $apic_system_id           = $::pmlc_neutron::apic_system_id,
  $enable_isolated_metadata = $::pmlc_neutron::enable_isolated_metadata,
  $use_namespaces           = $::pmlc_neutron::use_namespaces,
  $enable_metadata_network  = $::pmlc_neutron::enable_metadata_network,
) inherits ::pmlc_neutron {

  $conf     = '/etc/neutron/neutron.conf'
  $apipaste = '/etc/neutron/api-paste.ini'
  $dhcpconf = '/etc/neutron/dhcp_agent.ini'

  #########################
  ### API paste config ####
  #########################

  # API paste auth settings
  file_line { 'neutron_apipaste_admin_user':
    path  => $apipaste,
    line  => "admin_user=${admin_user}",
    match => '^admin_user.*$',
  }

  file_line { 'neutron_apipaste_admin_password':
    path  => $apipaste,
    line  => "admin_password=${admin_password}",
    match => '^admin_password.*$',
  }

  #########################
  ### DHCP agent config ###
  #########################

  file_line { 'neutron_dhcp_debug_logging':
    path  => $dhcpconf,
    line  => "debug = ${debug}",
    match => '^debug.*$',
  }

  file_line { 'neutron_dhcp_enable_isolated_metadata':
    path  => $dhcpconf,
    line  => "enable_isolated_metadata = ${enable_isolated_metadata}",
    match => '^enable_isolated_metadata.*$',
  }

  file_line { 'neutron_dhcp_use_namespaces':
    path  => $dhcpconf,
    line  => "use_namespaces = ${use_namespaces}",
    match => '^use_namespaces.*$',
  }

  file_line { 'neutron_dhcp_enable_metadata_network':
    path  => $dhcpconf,
    line  => "enable_metadata_network = ${enable_metadata_network}",
    match => '^enable_metadata_network.*$',
  }

  ######################
  ### Neutron Config ###
  ######################

  # Debug logging for neutron
  file_line { 'neutron_debug_logging':
    path  => $conf,
    line  => "debug = ${debug}",
    match => '^debug.*$',
  }

  # Neutron plugin to use
  file_line { 'neutron_core_plugin':
    path  => $conf,
    line  => "core_plugin = ${core_plugin}",
    match => '^core_plugin.*$',
  }

  # Neutron backends to load
  file_line { 'neutron_service_plugins':
    path  => $conf,
    line  => "service_plugins =${service_plugins}",
    match => '^service_plugins.*$',
  }

  # DHCP and subnet settings
  file_line { 'neutron_dhcp_lease_duration':
    path  => $conf,
    line  => "dhcp_lease_duration = ${dhcp_lease_duration}",
    match => '^dhcp_lease_duration.*$',
  }

  file_line { 'neutron_allow_overlapping_ips':
    path  => $conf,
    line  => "allow_overlapping_ips = ${allow_overlapping_ips}",
    match => '^allow_overlapping_ips.*$',
  }

  file_line { 'neutron_router_scheduler_driver':
    path  => $conf,
    line  => "router_scheduler_driver = ${router_scheduler_driver}",
    match => '^router_scheduler_driver.*$',
  }

  file_line { 'neutron_dhcp_agents_per_network':
    path  => $conf,
    line  => "dhcp_agents_per_network = ${dhcp_agents_per_network}",
    match => '^dhcp_agents_per_network.*$',
  }

  # Neutron API workers
  file_line { 'neutron_api_workers':
    path  => $conf,
    line  => "api_workers = ${api_workers}",
    match => '^api_workers.*$',
  }

  # Nova auth settings
  file_line { 'neutron_nova_admin_user':
    path  => $conf,
    line  => "nova_admin_username =${nova_admin_user}",
    match => '^nova_admin_username.*$',
  }

  file_line { 'neutron_nova_admin_pass':
    path  => $conf,
    line  => "nova_admin_password =${nova_admin_pass}",
    match => '^nova_admin_password.*$',
  }

  # RabbitMQ settings
  file_line { 'neutron_rabbit_user':
    path  => $conf,
    line  => "rabbit_userid=${rabbit_user}",
    match => '^rabbit_userid.*$',
  }

  file_line { 'neutron_rabbit_password':
    path  => $conf,
    line  => "rabbit_password=${rabbit_password}",
    match => '^rabbit_password.*$',
  }

  file_line { 'neutron_rabbit_virtualhost':
    path  => $conf,
    line  => "rabbit_virtual_host=${rabbit_virtualhost}",
    match => '^rabbit_virtual_host.*$',
  }

  # Notification driver. Defaults to messaging
  file_line { 'neutron_notification_driver':
    path  => $conf,
    line  => "notification_driver=${notification_driver}",
    match => '^notification_driver.*$',
  }

  # Neutron authentication
  file_line { 'neutron_root_helper':
    path  => $conf,
    line  => "root_helper = ${root_helper}",
    match => '^root_helper.*$',
  }

  file_line { 'neutron_admin_password':
    path  => $conf,
    line  => "admin_password = ${admin_password}",
    match => '^admin_password.*$',
  }

  file_line { 'neutron_admin_user':
    path  => $conf,
    line  => "admin_user = ${admin_user}",
    match => '^admin_user.*$',
  }

  # MySQL connection to neutron DB
  file_line { 'neutron_database_connection':
    path  => $conf,
    line  => "connection = mysql://${database_user}:${database_pass}@${management_vip}/neutron?&read_timeout=60",
    match => '^connection = mysql.*$',
  }

  # RPC workers for neutron.
  file_line { 'neutron_rpc_workers':
    path  => $conf,
    line  => "rpc_workers = ${rpc_workers}",
    match => '^rpc_workers.*$',
  }


  #########################
  ### ACI Configuration ###
  #########################
  if $use_aci == true {
    file { 'ml2_conf_cisco':
      ensure  => 'file',
      path    => '/etc/neutron/plugins/ml2/ml2_conf_cisco.ini',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('pmlc_neutron/ml2_conf_cisco.ini.erb'),
    }
  }
}

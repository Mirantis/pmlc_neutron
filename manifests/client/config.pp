# == Class: pmlc_neutron::client::config
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
class pmlc_neutron::client::config (
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

  ######################
  ### Neutron Config ###
  ######################

  # Debug logging for neutron
  ini_setting { 'neutron_debug_logging':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'debug',
    value   => ${debug},
    
  }

  # Neutron plugin to use
  ini_setting { 'neutron_core_plugin':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'core_plugin',
    value   => ${core_plugin},
  }

  # DHCP and subnet settings
  ini_setting { 'neutron_dhcp_lease_duration':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'dhcp_lease_duration',
    value   => ${dhcp_lease_duration},
  }

  # Allow tenant networks to use the same CIDR ranges
  ini_setting { 'neutron_allow_overlapping_ips':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'allow_overlapping_ips',
    value   => ${allow_overlapping_ips},
  }

  ini_setting { 'neutron_router_scheduler_driver':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'router_scheduler_driver',
    value   => ${router_scheduler_driver},
  }

  # Number of DHCP agents per network
  ini_setting { 'neutron_dhcp_agents_per_network':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'dhcp_agents_per_network',
    value   => ${dhcp_agents_per_network},
  }

  # Neutron API workers
  ini_setting { 'neutron_api_workers':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'api_workers',
    value   => ${api_workers},
  }

  # Nova auth settings
  ini_setting { 'neutron_nova_admin_user':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'nova_admin_username',
    value   => ${nova_admin_user},
  }

  ini_setting { 'neutron_nova_admin_pass':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'nova_admin_password',
    value   => ${nova_admin_pass},
  }

  # RabbitMQ settings
  ini_setting { 'neutron_rabbit_user':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'rabbit_userid',
    value   => ${rabbit_user},
  }

  ini_setting { 'neutron_rabbit_password':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'rabbit_password',
    value   => ${rabbit_password},
  }

  ini_setting { 'neutron_rabbit_virtualhost':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'rabbit_virtual_host',
    value   => ${rabbit_virtualhost},
  }

  # Neutron authentication
  ini_setting { 'neutron_root_helper':
    ensure  => 'present',
    path    => $conf,
    section => 'agent',
    setting => 'root_helper',
    value   => ${root_helper},
  }

  ini_setting { 'neutron_admin_password':
    ensure  => 'present',
    path    => $conf,
    section => 'keystone_authtoken',
    setting => 'admin_password',
    value   => '%SERVICE_PASSWORD%',
  }

  ini_setting { 'neutron_admin_user':
    ensure  => 'present',
    path    => $conf,
    section => 'keystone_authtoken',
    setting => 'admin_user',
    value   => '%SERVICE_USER%',
  }

  # MySQL connection to neutron DB
  ini_setting { 'neutron_database_connection':
    ensure  => 'present',
    path    => $conf,
    section => 'database',
    setting => 'connection',
    value   => "mysql://${database_user}:${database_pass}@${management_vip}/neutron?&read_timeout=60",
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

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
  $debug                       = $::pmlc_neutron::debug,
  $management_vip              = $::pmlc_neutron::management_vip,
  $core_plugin                 = $::pmlc_neutron::core_plugin,
  $service_plugins             = $::pmlc_neutron::service_plugins,
  $dhcp_lease_duration         = $::pmlc_neutron::dhcp_lease_duration,
  $allow_overlapping_ips       = $::pmlc_neutron::allow_overlapping_ips,
  $router_scheduler_driver     = $::pmlc_neutron::router_scheduler_driver,
  $dhcp_agents_per_network     = $::pmlc_neutron::dhcp_agents_per_network,
  $api_workers                 = $::pmlc_neutron::api_workers,
  $nova_admin_user             = $::pmlc_neutron::nova_admin_user,
  $nova_admin_pass             = $::pmlc_neutron::nova_admin_pass,
  $rabbit_user                 = $::pmlc_neutron::rabbit_user,
  $rabbit_password             = $::pmlc_neutron::rabbit_password,
  $rabbit_virtualhost          = $::pmlc_neutron::rabbit_virtualhost,
  $notification_driver         = $::pmlc_neutron::notification_driver,
  $root_helper                 = $::pmlc_neutron::root_helper,
  $admin_user                  = $::pmlc_neutron::admin_user,
  $admin_password              = $::pmlc_neutron::admin_password,
  $database_user               = $::pmlc_neutron::database_user,
  $database_pass               = $::pmlc_neutron::database_pass,
  $rpc_workers                 = $::pmlc_neutron::rpc_workers,
  $use_aci                     = $::pmlc_neutron::aci,
  $apic_hosts                  = $::pmlc_neutron::apic_hosts,
  $apic_username               = $::pmlc_neutron::apic_username,
  $apic_password               = $::pmlc_neutron::apic_password,
  $apic_name_mapping           = $::pmlc_neutron::apic_name_mapping,
  $apic_provision_hostlinks    = $::pmlc_neutron::apic_provision_hostlinks,
  $shared_context_name         = $::pmlc_neutron::shared_context_name,
  $apic_root_helper            = $::pmlc_neutron::apic_root_helper,
  $apic_vpc_pairs              = $::pmlc_neutron::apic_vlc_pairs,
  $apic_provision_infra        = $::pmlc_neutron::apic_provision_infra,
  $external_epg                = $::pmlc_neutron::external_epg,
  $preexisting                 = $::pmlc_neutron::preexisting,
  $apic_system_id              = $::pmlc_neutron::apic_system_id,
  $certificate_name            = $::pmlc_neutron::certificate_name,
  $private_key_file            = $::pmlc_neutron::private_key_file,
  $integrated_topology_service = $::pmlc_neutron::integrated_topology_service,
  $apic_agent_report_interval  = $::pmlc_neutron::apic_agent_report_interval,
  $apic_agent_poll_interval    = $::pmlc_neutron::apic_agent_poll_interval,
  $enable_isolated_metadata    = $::pmlc_neutron::enable_isolated_metadata,
  $use_namespaces              = $::pmlc_neutron::use_namespaces,
  $enable_metadata_network     = $::pmlc_neutron::enable_metadata_network,
) inherits ::pmlc_neutron {

  $conf     = '/etc/neutron/neutron.conf'
  $apipaste = '/etc/neutron/api-paste.ini'
  $dhcpconf = '/etc/neutron/dhcp_agent.ini'
  $cisco    = '/etc/neutron/plugins/ml2/ml2_conf_cisco.ini'

  #########################
  ### API paste config ####
  #########################

  # API paste auth settings
  ini_setting { 'neutron_apipaste_admin_user':
    ensure  => 'present',
    path    => $apipaste,
    section => 'filter:authtoken',
    setting => 'admin_user',
    value   => $admin_user,
  }

  ini_setting { 'neutron_apipaste_admin_password':
    ensure  => 'present',
    path    => $apipaste,
    section => 'filter:authtoken',
    setting => 'admin_password',
    value   => $admin_password,
  }

  #########################
  ### DHCP agent config ###
  #########################

  ini_setting { 'neutron_dhcp_debug_logging':
    ensure  => 'present',
    path    => $dhcpconf,
    section => 'DEFAULT',
    setting => 'debug',
    value   => $debug,
  }

  ini_setting { 'neutron_dhcp_enable_isolated_metadata':
    ensure  => 'present',
    path    => $dhcpconf,
    section => 'DEFAULT',
    setting => 'enable_isolated_metadata',
    value   => $enable_isolated_metadata,
  }

  ini_setting { 'neutron_dhcp_use_namespaces':
    ensure  => 'present',
    path    => $dhcpconf,
    section => 'DEFAULT',
    setting => 'use_namespaces',
    value   => $use_namespaces,
  }

  ini_setting { 'neutron_dhcp_enable_metadata_network':
    ensure  => 'present',
    path    => $dhcpconf,
    section => 'DEFAULT',
    setting => 'enable_metadata_network',
    value   => $enable_metadata_network,
  }

  ######################
  ### Neutron Config ###
  ######################

  # Debug logging for neutron
  ini_setting { 'neutron_debug_logging':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'debug',
    value   => $debug,
  }

  # Neutron plugin to use
  ini_setting { 'neutron_core_plugin':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'core_plugin',
    value   => $core_plugin,
  }

  # Neutron backends to load
  ini_setting { 'neutron_service_plugins':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'service_plugins',
    value   => $service_plugins,
  }

  # DHCP and subnet settings
  ini_setting { 'neutron_dhcp_lease_duration':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'dhcp_lease_duration',
    value   => $dhcp_lease_duration,
  }

  ini_setting { 'neutron_allow_overlapping_ips':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'allow_overlapping_ips',
    value   => $allow_overlapping_ips,
  }

  ini_setting { 'neutron_router_scheduler_driver':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'router_scheduler_driver',
    value   => $router_scheduler_driver,
  }

  ini_setting { 'neutron_dhcp_agents_per_network':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'dhcp_agents_per_network',
    value   => $dhcp_agents_per_network,
  }

  # Neutron API workers
  ini_setting { 'neutron_api_workers':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'api_workers',
    value   => $api_workers,
  }

  # Nova auth settings
  ini_setting { 'neutron_nova_admin_user':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'nova_admin_username',
    value   => $nova_admin_user,
  }

  ini_setting { 'neutron_nova_admin_pass':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'nova_admin_password',
    value   => $nova_admin_pass,
  }

  # RabbitMQ settings
  ini_setting { 'neutron_rabbit_user':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'rabbit_userid',
    value   => $rabbit_user,
  }

  ini_setting { 'neutron_rabbit_password':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'rabbit_password',
    value   => $rabbit_password,
  }

  ini_setting { 'neutron_rabbit_virtualhost':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'rabbit_virtual_host',
    value   => $rabbit_virtualhost,
  }

  # Notification driver. Defaults to messaging
  ini_setting { 'neutron_notification_driver':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'notification_driver',
    value   => $notification_driver,
  }

  # Neutron authentication
  ini_setting { 'neutron_root_helper':
    ensure  => 'present',
    path    => $conf,
    section => 'agent',
    setting => 'root_helper',
    value   => $root_helper,
  }

  ini_setting { 'neutron_admin_password':
    ensure  => 'present',
    path    => $conf,
    section => 'keystone_authtoken',
    setting => 'neutron_admin_password',
    value   => $admin_password,
  }

  ini_setting { 'neutron_admin_user':
    ensure  => 'present',
    path    => $conf,
    section => 'keystone_authtoken',
    setting => 'admin_user',
    value   => $admin_user,
  }

  # MySQL connection to neutron DB
  ini_setting { 'neutron_database_connection':
    ensure  => 'present',
    path    => $conf,
    section => 'database',
    setting => 'connection',
    value   => "mysql://${database_user}:${database_pass}@${management_vip}/neutron?&read_timeout=60",
  }

  # RPC workers for neutron.
  ini_setting { 'neutron_rpc_workers':
    ensure  => 'present',
    path    => $conf,
    section => 'DEFAULT',
    setting => 'rpc_workers',
    value   => $rpc_workers,
  }


  #########################
  ### ACI Configuration ###
  #########################
  if $use_aci == true {
    ini_setting { 'apic_hosts':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_hosts',
      value   => $apic_hosts,
    }

    ini_setting { 'apic_username':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_username',
      value   => $apic_username,
    }

    ini_setting { 'apic_password':
      ensure  => 'absent',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_password',
    }

    ini_setting { 'certificate_name':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'certificate_name',
      value   => $certificate_name,
    }

    ini_setting { 'private_key_file':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'private_key_file',
      value   => $private_key_file,
    }

    ini_setting { 'apic_name_mapping':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_name_mapping',
      value   => $apic_name_mapping,
    }

    ini_setting { 'integrated_topology_service':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'integrated_topology_service',
      value   => $integrated_topology_service,
    }

    ini_setting { 'apic_agent_report_interval':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_agent_report_interval',
      value   => $apic_agent_report_interval,
    }

    ini_setting { 'apic_agent_poll_interval':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_agent_poll_interval',
      value   => $apic_agent_poll_interval,
    }

    ini_setting { 'apic_provision_hostlinks':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_provision_hostlinks',
      value   => $apic_provision_hostlinks,
    }

    ini_setting { 'shared_context_name':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'shared_context_name',
      value   => $shared_context_name,
    }

    ini_settings { 'apic root helper':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'root_helper',
      value   => $apic_root_helper,
    }

    ini_setting { 'APIC vpc pairs':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_vpc_pairs',
      value   => $apic_vpc_pairs,
    }

    ini_setting { 'APIC provision infra':
      ensure  => 'present',
      path    => $cisco,
      section => 'ml2_cisco_apic',
      setting => 'apic_provision_infra',
      value   => $apic_provision_infra,
    }

    ini_setting { 'External EPG':
      ensure  => 'present',
      path    => $cisco,
      section => 'apic_external_network:ehnet_ext',
      setting => 'external_epg',
      value   => $external_epg,
    }

    ini_setting { 'preexisting':
      ensure  => 'present',
      path    => $cisco,
      section => 'apic_external_network:ehnet_ext',
      setting => 'preexisting',
      value   => $preexisting,
    }

    ini_setting { 'APIC system id':
      ensure  => 'present',
      path    => $cisco,
      section => 'DEFAULT',
      setting => 'apic_system_id',
      value   => $apic_system_id,
    }
  }
}

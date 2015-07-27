# pmlc_neutron
This module is for basic neutron management.  It was written to provide basic config changes to neutron via the Fuel master.  It is not intended to be a fully-functional openstack/neutron configuration management module to deploy neutron from scratch.  It is merely to allow config changes and ensure neutron services are running after deploying with Fuel.

## Example Usage
```puppet
class { '::pmlc_neutron':
  debug                    => $debug,
  is_server                => True,
  rabbit_pass              => $rabbit_pass,
  database_password        => $database_password,
  use_aci                  => True,
  apic_hosts               => $apic_hosts,
  apic_password            => $apic_password,
  shared_context_name      => $shared_context_name,
  apic_vpc_pairs           => $apic_vpc_pairs,
  external_epg             => $external_epg,
  enable_isolated_metadata => True,
}
```

## Parameters
Most parameters are optional but you'd likely want to supply different/correct access credentials. $is_server is a required parameter so the module knows whether to setup as a neutron server or client.  This module does not currently do any MySQL grants or RabbitMQ permissions.  If those passwords change, then you'd need to update the configuration here but this module does not make any changes in RabbitMQ or MySQL.  If using ACI, it is required to fill in the access information, external EPG, vpc pairs, shared context name, etc.

* $debug        - Turn on debug logging for Neutron
* $is_server    - *REQUIRED* Whether to setup neturon server or client
* $management_vip - The management vip to use for MySQL connection.  Defaults to hiera(management_vip)
* $core_plugin     - The core plugin to use.  Defaults to ML2
* $service_plugins - The service plugins to use.  Defaults to neutron l3 router and ceilometer. Switches automatically to ACI if $use_aci is set to True
* $dhcp_lease_duration - How long the dhcp lease should be for instances
* $allow_overlapping_ips - Whether or not to allow different networks to use the same ip ranges
* $router_scheduler_driver - The router scheduler driver to use
* $dhcp_agents_per_network - Number of DHCP agents to assign to each network. Defaults to 2.
* $api_workers             - The number of API worker processes to spawn.
* $nova_admin_user         - The admin user for nova integration
* $nova_admin_pass         - The admin password for nova integration
* $rabbit_user             - User for RabbitMQ
* $rabbit_password         - Password for RabbitMQ
* $rabbit_virtualhost      - Vhost in RabbitMQ to use
* $notification_driver     - The notification driver for neutron. Defaults to messaging.  Noop can also be set.
* $root_helper             - The root helper for neutron
* $admin_user              - The neutron admin user
* $admin_password          - Password for neutron admin user
* $database_user           - MySQL user for neutron
* $database_pass           - MySQL password for neutron db user
* $rpc_workers             - Number of neutron RPC workers to start. This is an experimental feature in Juno
* $use_aci                 - Whether or not to use Cisco ACI driver. Defaults to false
* $apic_hosts              - Comma separated list of your APIC host ip addresses
* $apic_username           - Username to use for APIC authentication. Defaults to admin
* $apic_password           - The password for APIC user. Required if using ACI as it defaults to undef
* $apic_name_mapping       - APIC name mapping
* $apic_provision_hostlinks - APIC setting for provision hostlinks
* $shared_context_name      - The shared context name in APIC
* $apic_root_helper         - root helper for apic driver. Defaults to 'sudo'
* $apic_vpc_pairs           - The VPC pairs to use.  Pairs should be the leaf IDs
* $apic_provision_infra     - Provision infrastructure
* $external_epg             - The name of the EPG for your external network access from neutron
* $preexisting              - Whether network is preexisting
* $enable_isolated_metadata - Enable isolated metadata in dhcp agent to allow for routable tenant networks. Defaults to false.
* $use_namespaces           - Allow ip overlap in dhcp agent. Defaults to true.
* $enable_metadata_network  - Enable metadata network if routes are not using router. defaults to false.

default['glb']['dpdk']['interface'] = node['network']['default_interface'] || 'vglb_kni0'
default['glb']['dpdk']['version'] = '17.11.1-6'
default['glb']['router']['v4'] = node['network']['default_gateway']
default['glb']['router']['v6'] = node['network']['default_inet6_gateway']

# This configuration gets translated into the director configuration
default['glb']['conf']['outbound_gateway_mac'] = node['network']['interfaces'][node['network']['default_interface']]['arp'][node['network']['default_gateway']]
default['glb']['conf']['outbound_src_ip'] = node['ipaddress']
default['glb']['conf']['forward_icmp_ping_responses'] = true
default['glb']['conf']['num_worker_queues'] = 1
default['glb']['conf']['rx_drop_en'] = false
default['glb']['conf']['flow_paths'] = [{
                                         rx_port: 0,
                                         rx_queue: 0,
                                         tx_port: 0,
                                         tx_queue: 0
                                       }]
default['glb']['conf']['lcores']['lcore-1']['rx'] = true
default['glb']['conf']['lcores']['lcore-1']['tx'] = true
default['glb']['conf']['lcores']['lcore-1']['rx'] = true
default['glb']['conf']['lcores']['lcore-1']['flow_paths'] = [0]
default['glb']['conf']['lcores']['lcore-1']['dist'] = true
default['glb']['conf']['lcores']['lcore-1']['num_dist_workers'] = 1
default['glb']['conf']['lcores']['lcore-1']['kni'] = true
default['glb']['conf']['lcores']['lcore-2']['work'] = true
default['glb']['conf']['lcores']['lcore-2']['work_source'] = 1

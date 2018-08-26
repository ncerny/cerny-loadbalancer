if node['domain'].eql?('integration.cerny.cc')
  default['glb']['dpdk']['interface'] = 'ens18'

  default['glb']['forwarding_table']['name'] = "integration.cerny.cc"
  default['glb']['forwarding_table']['hash_key'] = "45b96fc42f0a93df7faf5fce4986e9b5"
  default['glb']['forwarding_table']['seed'] = "78e5357eacf826e50701162d3e544871"
  default['glb']['forwarding_table']['binds'] = %w( 192.168.254.30/32 )
  default['glb']['forwarding_table']['ports'] = %w( 80 443 8006 32400 )
  default['glb']['forwarding_table']['backends']['192.168.130.7'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.130.8'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.130.9'] = 'active'
end

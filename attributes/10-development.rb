if node['domain'].eql?('development.cerny.cc')
  default['glb']['dpdk']['interface'] = 'ens18'

  default['glb']['forwarding_table']['name'] = "development.cerny.cc"
  default['glb']['forwarding_table']['hash_key'] = "ed0117060f40299c5a23f2430e1e91a3"
  default['glb']['forwarding_table']['seed'] = "beee423b7510696c2a5a9a7e0b402ea3"
  default['glb']['forwarding_table']['binds'] = %w( 192.168.254.10/32 )
  default['glb']['forwarding_table']['ports'] = [ 80, 443, 8006, 32400 ]
  default['glb']['forwarding_table']['backends']['192.168.110.7'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.110.8'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.110.9'] = 'active'
end

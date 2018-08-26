if node['domain'].eql?('delivered.cerny.cc')
  default['glb']['dpdk']['interface'] = 'ens18'
  
  default['glb']['forwarding_table']['name'] = "delivered.cerny.cc"
  default['glb']['forwarding_table']['hash_key'] = "30c3200480ad46c0d667b60ed92ce36a"
  default['glb']['forwarding_table']['seed'] = "17bf51343c5cae690e3fad67e7ecc36e"
  default['glb']['forwarding_table']['binds'] = %w( 192.168.254.50/32 )
  default['glb']['forwarding_table']['ports'] = %w( 80 443 8006 32400 )
  default['glb']['forwarding_table']['backends']['192.168.150.7'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.150.8'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.150.9'] = 'active'
end

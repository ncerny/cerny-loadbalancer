if node['domain'].eql?('staging.cerny.cc')
  default['glb']['dpdk']['interface'] = 'ens18'

  default['glb']['forwarding_table']['name'] = "staging.cerny.cc"
  default['glb']['forwarding_table']['hash_key'] = "b43f5d989f0d73e0d6680a30f0ff4150"
  default['glb']['forwarding_table']['seed'] = "5a41dcc693a92517b7ec40b1992439a1"
  default['glb']['forwarding_table']['binds'] = %w( 192.168.254.40/32 )
  default['glb']['forwarding_table']['ports'] = %w( 80 443 8006 32400 )
  default['glb']['forwarding_table']['backends']['192.168.140.7'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.140.8'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.140.9'] = 'active'
end

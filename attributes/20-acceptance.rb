if node['domain'].eql?('acceptance.cerny.cc')
  default['glb']['dpdk']['interface'] = 'ens18'

  default['glb']['forwarding_table']['name'] = "acceptance.cerny.cc"
  default['glb']['forwarding_table']['hash_key'] = "93b9024bb9e610f8b933a5cd472d3e2f"
  default['glb']['forwarding_table']['seed'] = "242d94bc7ed12e940c6b7cc59fca76e7"
  default['glb']['forwarding_table']['binds'] = %w( 192.168.254.20 )
  default['glb']['forwarding_table']['ports'] = %w( 80 443 8006 32400 )
  default['glb']['forwarding_table']['backends']['192.168.120.7'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.120.8'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.120.9'] = 'active'
end

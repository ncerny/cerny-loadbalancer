if node['domain'].eql?('infra.cerny.cc')
  default['glb']['dpdk']['interface'] = 'ens18'

  default['glb']['forwarding_table']['name'] = "infra.cerny.cc"
  default['glb']['forwarding_table']['hash_key'] = "e2fe91716377d9a9bd122bfc63095ac3"
  default['glb']['forwarding_table']['seed'] = "f77d7cab903fcb95e995ccd5aa2d104c"
  default['glb']['forwarding_table']['binds'] = %w( 192.168.254.0/32 )
  default['glb']['forwarding_table']['ports'] = [ 80, 443, 8006 ]
  default['glb']['forwarding_table']['backends']['192.168.20.31'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.20.32'] = 'active'
  default['glb']['forwarding_table']['backends']['192.168.20.33'] = 'active'
end

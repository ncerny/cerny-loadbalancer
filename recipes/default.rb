#
# Cookbook:: cerny-loadbalancer
# Recipe:: default
#
# Copyright:: 2018, Nathan Cerny
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
errors = []
errors << 'ERROR: GLB Director only supports Debian operating Systems' unless node['platform'].eql?('debian')
errors << 'ERROR: GLB Director requires at least 3 physical cores' unless node['cpu']['cores'] >= 3
unless errors.empty?
  errors.each do |error|
    puts error
  end
  raise 'Aborting Chef-Client run due to errors.'
end

iface = (node['network']['interfaces'].include?(node['glb']['dpdk']['interface']) ? node['glb']['dpdk']['interface'] : 'vglb_kni0')
addr, addr_props = node['network']['interfaces'][iface]['addresses'].select { |_, v| v['scope'].eql?('Global') && v['family'].eql?('inet') }.first
routes = node['network']['interfaces'][iface]['routes'].select { |a| a['destination'].eql?('default') }

include_recipe "#{cookbook_name}::deps"

sysctl 'vm.nr_hugepages' do
  value 512
end

directory '/mnt/huge'

mount '/mnt/huge' do
  action :enable
  device 'hugetlbfs'
  fstype 'hugetlbfs'
  options 'mode=1770'
  dump 0
  pass 0
end

# action :mount of mount resource doesn't like hugetlbfs.
execute 'mount -a' do
  not_if { node['filesystem']['by_device']['hugetlbfs']['mounts'].include?('/mnt/huge') }
end

%w(
  glb-director
  glb-healthcheck
).each do |pkg|
  package pkg
end

%w(
  rte_kni
  igb_uio
).each do |mod|
  kernel_module mod
end

template '/etc/bird/bird.conf' do
  source 'bird.conf.erb'
  notifies :restart, 'service[bird]'
end

template '/etc/glb/forwarding_table.src.json' do
  source 'forwarding_table.json.erb'
  notifies :reload, 'service[glb-healthcheck]', :immediately
end

template '/etc/default/glb-director' do
  source 'glb-director.erb'
  variables master: 0,
            cores: 0.upto(node['cpu']['cores'] - 2).to_a
  notifies :restart, 'service[glb-director]'
end

file '/etc/glb/director.conf' do
  content JSON.pretty_generate(node['glb']['conf'])
  notifies :restart, 'service[glb-director]'
end

directory '/etc/systemd/system/glb-director.service.d'

file '/etc/systemd/system/glb-director.service.d/10-dpdk-devbind.conf' do
  content <<-EOH
    [Service]
    ExecStartPre=-/sbin/ip link set #{iface} down
    ExecStartPre=-/sbin/dpdk-devbind --bind=igb_uio #{iface}
  EOH
  not_if { iface.eql?('vglb_kni0') }
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

template '/etc/udev/rules.d/70-persistent-net.rules' do
  source 'udev-net-rules.erb'
  variables addr: addr,
            pref: addr_props['prefixlen'],
            routes: routes
  notifies :restart, 'service[systemd-udevd]', :immediately
end

%w(
  bird
  glb-director
  glb-healthcheck
).each do |svc|
  service svc do
    action [:enable, :start]
  end
end

service 'systemd-udevd' do
  action :nothing
end

execute 'systemctl daemon-reload' do
  action :nothing
end

#
# Cookbook:: cerny-loadbalancer
# Recipe:: proxy
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

include_recipe "#{cookbook_name}::deps"

package 'glb-redirect-iptables-dkms'
kernel_module 'fou'

systemd_unit 'glb-redirect.service' do
  action [:create, :enable, :start]
  content <<-EOU.gsub(/^\s+/, '')
    [Unit]
    Description=Configure GUE and IPTables Rules for GLB proxy layer.
    After=network.target

    [Service]
    ExecStart=/bin/ip fou add port 19523 gue
    ExecStartPost=/bin/ip link set up dev tunl0
    ExecStartPost=/bin/ip addr add #{node['glb']['forwarding_table']['binds'].first} dev tunl0
    ExecStartPost=-/sbin/iptables -t raw -A INPUT -p udp -m udp --dport 19523 -j CT --notrack
    ExecStartPost=-/sbin/iptables -A INPUT -p udp -m udp --dport 19523 -j GLBREDIRECT

    ExecStop=/bin/ip fou del port 19523 gue
    ExecStopPost=/bin/ip addr del #{node['glb']['forwarding_table']['binds'].first} dev tunl0
    ExecStopPost=/bin/ip link set down dev tunl0
    RemainAfterExit=true

    [Install]
    WantedBy=multi-user.target
  EOU
end

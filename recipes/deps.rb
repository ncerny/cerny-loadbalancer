#
# Cookbook:: cerny-loadbalancer
# Recipe:: deps
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

raise 'ERROR: GLB Director only supports Debian operating Systems' unless node['platform'].eql?('debian')

package 'apt-transport-https'
packagecloud_repo 'github/unofficial-dpdk-stable'
packagecloud_repo 'github/glb-director'

%W(
  linux-headers-#{node['kernel']['release']}
  build-essential
  dpdk-dev=#{node['glb']['dpdk']['version']}
  dpdk=#{node['glb']['dpdk']['version']}
).each do | pkg |
  name, version = pkg.split('=')
  package name do
    action :install
    version version if version
  end
end

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

package 'apt-transport-https'

packagecloud_repo 'github/unofficial-dpdk-stable' do
  type 'deb'
end

packagecloud_repo 'github/glb-director' do
  type 'deb'
end

%W(
  linux-headers-#{node['kernel']['release']}
  build-essential
  bird
  dpdk-dev=#{node['glb']['dpdk']['version']}
  dpdk=#{node['glb']['dpdk']['version']}
  dpdk-rte-kni-dkms
  dpdk-igb-uio-dkms
).each do | pkg |
  name, version = pkg.split('=')
  package name do
    action :install
    version version if version
  end
end

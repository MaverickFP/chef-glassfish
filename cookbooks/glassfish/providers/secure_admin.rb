#
# Copyright Peter Donald
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
#

include Chef::Asadmin

use_inline_resources

action :enable do
  if new_resource.init_style == 'upstart'
    service "glassfish-#{new_resource.domain_name}" do
      provider Chef::Provider::Service::Upstart
      supports :restart => true, :status => true
      action :nothing
    end
  elsif new_resource.init_style == 'runit'
    runit_service "glassfish-#{new_resource.domain_name}" do
      sv_timeout 100
      supports :restart => true, :status => true
      action :nothing
    end
  else
    raise "Unknown init style #{new_resource.init_style}"
  end

  bash 'asadmin_enable-secure-admin' do
    not_if "#{asadmin_command('get secure-admin.enabled')} | grep -F -x -- 'secure-admin.enabled=true'"
    user new_resource.system_user
    group new_resource.system_group
    code asadmin_command('enable-secure-admin')
    notifies :restart, "service[glassfish-#{new_resource.domain_name}]", :immediate if new_resource.init_style == 'upstart'
    notifies :restart, "runit_service[glassfish-#{new_resource.domain_name}]", :immediate if new_resource.init_style == 'runit'
  end
end

action :disable do
  service "glassfish-#{new_resource.domain_name}" do
    provider Chef::Provider::Service::Upstart if new_resource.init_style == 'upstart'
    supports :restart => true, :status => true
    action :nothing
  end

  bash 'asadmin_disable-secure-admin' do
    only_if "#{asadmin_command('get secure-admin.enabled')} | grep -F -x -- 'secure-admin.enabled=true'"
    user new_resource.system_user
    group new_resource.system_group
    code asadmin_command('disable-secure-admin')
    notifies :restart, "service[glassfish-#{new_resource.domain_name}]", :immediate
  end
end

#
# Cookbook:: aikcu-demo
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'apt::default'
include_recipe 'aikcu-demo::users'

if node.platform_family? 'rhel'
  apache_name = 'httpd'
else
  apache_name = 'apache2'
end

package apache_name do
  action [:install]
end

service apache_name do
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  variables({
    :message => node['aikcu-demo']['message']
  })
end
# Author; Atul Srivastava
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, Relevance Lab
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get update" do
	command "apt-get update"
	action :run
	only_if {node['platform_family'] == "debian" }
end


package node['mysql']['package_name'] do
	action :install
end

service node['mysql']['service_name'] do
	action [:start ]
end

# Set root password

execute "set root password" do
	cwd "#{node['mysql']['mysqladmin_path']}"
	command "#{node['mysql']['mysqladmin_path']}/mysqladmin -u root password #{node['mysql']['root_password']}"
end

# delete all users other than root

execute "delete non root users" do
	cwd "#{node['mysql']['mysql_path']}"
	command "#{node['mysql']['mysql_path']}/mysql -uroot -p#{node['mysql']['root_password']} -e \"delete from mysql.user where User!=\'root\';\""
end

# create DB

execute "create DB" do
	cwd "#{node['mysql']['mysql_path']}"
	command "#{node['mysql']['mysql_path']}/mysql -uroot -p#{node['mysql']['root_password']} -e \"create database #{node['mysql']['db_name']};\" "
end

# FLUSH PRIVILEGES

execute "flush privileges" do
	cwd "#{node['mysql']['mysql_path']}"
	command "#{node['mysql']['mysql_path']}/mysql -uroot -p#{node['mysql']['root_password']} -e \"FLUSH PRIVILEGES;\" "
end

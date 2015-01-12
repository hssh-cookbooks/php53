#
# Cookbook Name:: php53
# Recipe:: default
#
# The MIT License (MIT)
# 
# Copyright (c) 2015 Hisashi KOMINE
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Disable selinux
template '/etc/selinux/config' do
  source 'selinux.config.erb'
  variables config: node['selinux']['config']
  notifies :run, 'execute[setenforce 0]'
end

execute 'setenforce 0' do
  action :nothing
end

# Enable EPEL repository
execute 'Enable EPEL repository' do
  command 'rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'
  not_if { File.exists?('/etc/yum.repos.d/epel.repo') }
end

packages = %w(
  httpd
  links
  php
  php-devel
  php-gd
  php-pdo
  php-mbstring
  php-mcrypt
  php-pecl-xdebug
  php-phpunit-PHPUnit
  logrotate
)
packages.each do |p|
  package p do
  end
end

# Setup apache
service 'httpd' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  notifies :restart, 'service[httpd]'
end

# Setup php
template '/etc/php.ini' do
  source 'php.ini.erb'
  variables settings: node['php53']['ini']
  notifies :restart, 'service[httpd]'
end

template '/etc/php.d/xdebug.ini' do
  source 'php.xdebug.ini.erb'
  variables settings: node['php53']['ini']
  notifies :restart, 'service[httpd]'
end

remote_file '/usr/local/bin/composer' do
  source 'https://getcomposer.org/composer.phar'
  mode 0755
end

remote_file '/usr/local/bin/psysh' do
  source 'http://psysh.org/psysh'
  mode 0755
end

remote_file '/usr/local/bin/sami' do
  source 'http://get.sensiolabs.org/sami.phar'
  mode 0755
end

directory '/var/log/php' do
  owner 'apache'
  group 'apache'
end

# Setup logrotate
template '/etc/logrotate.d/php' do
  source 'logrotate.php.erb'
end

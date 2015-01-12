#
# Cookbook Name:: php53
# Attribute:: default
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

#
# SELinux default settings
#
# SELINUX= can take one of these three values:
#   enforcing - SELinux security policy is enforced.
#   permissive - SELinux prints warnings instead of enforcing.
#   disabled - SELinux is fully disabled.
# SELINUXTYPE= type of policy in use. Possible values are:
#   targeted - Only targeted network daemons are protected.
#   strict - Full SELinux protection.
default['selinux']['config']['SELINUX']     = 'disabled'
default['selinux']['config']['SELINUXTYPE'] = 'targeted'

#
# php.ini default settings
#
default['php53']['ini'] = {
  'date.timezone' => 'Asia/Tokyo',
  'error_log' => '/var/log/php/error.log',

  # Entries listed below are picked up from php.ini 'Quick Reference'

  'display_errors' => 'Off',
  # Default Value: On
  # Development Value: On
  # Production Value: Off

  'display_startup_errors' => 'Off',
  # Default Value: Off
  # Development Value: On
  # Production Value: Off

  'error_reporting' => 'E_ALL & ~E_DEPRECATED & ~E_STRICT',
  # Default Value: E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED
  # Development Value: E_ALL
  # Production Value: E_ALL & ~E_DEPRECATED & ~E_STRICT

  'html_errors' => 'On',
  # Default Value: On
  # Development Value: On
  # Production value: On

  'log_errors' => 'On',
  # Default Value: Off
  # Development Value: On
  # Production Value: On

  'max_input_time' => '60',
  # Default Value: -1 (Unlimited)
  # Development Value: 60 (60 seconds)
  # Production Value: 60 (60 seconds)

  'output_buffering' => '4096',
  # Default Value: Off
  # Development Value: 4096
  # Production Value: 4096

  'register_argc_argv' => 'Off',
  # Default Value: On
  # Development Value: Off
  # Production Value: Off

  'request_order' => 'GP',
  # Default Value: None
  # Development Value: "GP"
  # Production Value: "GP"

  'session.gc_divisor' => '1000',
  # Default Value: 100
  # Development Value: 1000
  # Production Value: 1000

  'session.hash_bits_per_character' => '5',
  # Default Value: 4
  # Development Value: 5
  # Production Value: 5

  'short_open_tag' => 'Off',
  # Default Value: On
  # Development Value: Off
  # Production Value: Off

  'track_errors' => 'Off',
  # Default Value: Off
  # Development Value: On
  # Production Value: Off

  'url_rewriter.tags' => 'a=href,area=href,frame=src,input=src,form=fakeentry',
  # Default Value: "a=href,area=href,frame=src,form=,fieldset="
  # Development Value: "a=href,area=href,frame=src,input=src,form=fakeentry"
  # Production Value: "a=href,area=href,frame=src,input=src,form=fakeentry"

  'variables_order' => 'GPCS',
  # Default Value: "EGPCS"
  # Development Value: "GPCS"
  # Production Value: "GPCS"

  'xdebug.remote_port' => '9000',
  'xdebug.idekey' => 'ANYIDE',
}

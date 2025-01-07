#
# Cookbook:: errbit
# Recipe:: default
#
# Copyright:: 2025
# Authors:
#     Artiom Rogov <insidia93@gmail.com>

include_recipe 'errbit::mongo_install'
include_recipe 'errbit::create_user'
include_recipe 'errbit::errbit_install'
include_recipe 'errbit::create_unit'

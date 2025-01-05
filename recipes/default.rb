#
# Cookbook:: errbit
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

include_recipe 'errbit::mongo'
include_recipe 'errbit::user'
include_recipe 'errbit::install'
include_recipe 'errbit::unit'

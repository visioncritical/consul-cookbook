#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
::Chef::Node.send(:include, ConsulCookbook::Helpers)

# Only used on Linux
default['consul']['service_name'] = 'consul'
default['consul']['service_user'] = 'consul'
default['consul']['service_group'] = 'consul'

default['consul']['config']['bag_name'] = 'secrets'
default['consul']['config']['bag_item'] = 'consul'

if node['os'] == 'windows'
  config_dir_name  = 'conf.d'
else
  config_dir_name  = 'consul.d'
end

default['consul']['config']['path'] = join_path config_prefix_path, 'consul.json'
default['consul']['config']['data_dir'] = data_path
default['consul']['config']['ca_file'] = join_path config_prefix_path, 'ssl', 'CA', 'ca.crt'
default['consul']['config']['cert_file'] = join_path config_prefix_path, 'ssl', 'certs', 'consul.crt'
default['consul']['config']['key_file'] = join_path config_prefix_path, 'ssl', 'private', 'consul.key'

default['consul']['config']['client_addr'] = '0.0.0.0'
default['consul']['config']['ports'] = {
  'dns'      => 8600,
  'http'     => 8500,
  'rpc'      => 8400,
  'serf_lan' => 8301,
  'serf_wan' => 8302,
  'server'   => 8300
}

default['consul']['diplomat_version'] = nil

default['consul']['service']['config_dir'] = join_path config_prefix_path, config_dir_name
default['consul']['service']['data_dir'] = default['consul']['config']['data_dir']

default['consul']['service']['install_method'] = 'binary'
default['consul']['service']['binary_url'] = "https://releases.hashicorp.com/consul/%{version}/%{filename}.zip" # rubocop:disable Style/StringLiterals

default['consul']['service']['source_url'] = 'https://github.com/hashicorp/consul'

default['consul']['version'] = '0.6.0'
default['consul']['checksums'] = {
  'consul_0.5.0_darwin_amd64'  => '24d9758c873e9124e0ce266f118078f87ba8d8363ab16c2e59a3cd197b77e964',
  'consul_0.5.0_linux_386'     => '4b6147c30596a30361d4753d409f8a1af9518f54f5ed473a4c4ac973738ac0fd',
  'consul_0.5.0_linux_amd64'   => '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088',
  'consul_0.5.0_windows_386'   => '7fd760ee8a5c2756391cacc1e924ae602b16cdad838db068e564f798383ad714',
  'consul_0.5.0_web_ui'        => '0081d08be9c0b1172939e92af5a7cf9ba4f90e54fae24a353299503b24bb8be9',

  'consul_0.5.1_darwin_amd64'  => '06fef2ffc5a8ad8883213227efae5d1e0aa4192ccb772ec6086103a7a08fadf8',
  'consul_0.5.1_linux_386'     => 'dad93a02c01de885daee191bcc5a05ca2bf106200da61db33694a658432d8399',
  'consul_0.5.1_linux_amd64'   => '967ad75865b950698833eaf26415ba48d8a22befb5d4e8c77630ad70f251b100',
  'consul_0.5.1_windows_386'   => 'bb9e1753cf793ad6f9db34bd6e18fb0fa5b0696a8a51a7f1c61484386dfe6682',
  'consul_0.5.1_web_ui'        => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1',

  'consul_0.5.2_darwin_amd64'  => '87be515d7dbab760a61a359626a734f738d46ece367f68422b7dec9197d9eeea',
  'consul_0.5.2_linux_386'     => '29306ce398109f954ceeea3af79878be4fb0d949f8af3a27c95ccef2101e8f60',
  'consul_0.5.2_linux_amd64'   => '171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445',
  'consul_0.5.2_windows_386'   => '2e866812de16f1a6138a0fd1eebc76143f1314826e3b52597a55ac510ae94be6',
  'consul_0.5.2_web_ui'        => 'ad883aa52e1c0136ab1492bbcedad1210235f26d59719fb6de3ef6464f1ff3b1',

  'consul_0.6.0_darwin_386'    => '95d57bfcc287bc344ec3ae8372cf735651af1158c5b1345e6f30cd9a9c811815',
  'consul_0.6.0_darwin_amd64'  => '29ddff01368458048731afa586cec5426c8033a914b43fc83d6442e0a522c114',
  'consul_0.6.0_freebsd_386'   => 'c5eb9f5c211612148e1e1cd101670fd08fd1abf9b2e541ac2936ab9637626249',
  'consul_0.6.0_freebsd_amd64' => 'd7be5c95b971f48ccbd2c53c342dced9a3d0a5bc58f57b4f2e75672d96929923',
  'consul_0.6.0_freebsd_arm'   => '92f29ad00f8f44d3be43b3b038a904c332757eb2a6848a7d6754583c2791e18b',
  'consul_0.6.0_linux_386'     => 'f58f3f03a8b48d89bb8be94a6d1767393ad2a410c920b064066e01c7fa24f06c',
  'consul_0.6.0_linux_amd64'   => '307fa26ae32cb8732aed2b3320ed8daf02c28b50d952cbaae8faf67c79f78847',
  'consul_0.6.0_linux_arm'     => '425e7332789deb446a486ac25f7143aba5f16453ac46ede39b71ab6a361d8726',
  'consul_0.6.0_windows_386'   => '8379afd07668933c120880bba8228277e380abb14e07a6c45b94562ac19b37bd',
  'consul_0.6.0_windows_amd64' => '182beea0d8d346a9bfd70679621a5542aeeeea1f35be81fa3d3aeec2479bac3d',
  'consul_0.6.0_web_ui'        => '73c5e7ee50bb4a2efe56331d330e6d7dbf46335599c028344ccc4031c0c32eb0'
}

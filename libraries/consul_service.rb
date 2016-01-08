#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'
require_relative 'helpers'

module ConsulCookbook
  module Resource
    # Resource for managing the Consul service on an instance.
    # @since 1.0.0
    class ConsulService < Chef::Resource
      include Poise
      provides :consul_service
      actions :enable, :disable
      include PoiseService::ServiceMixin
      include ConsulCookbook::Helpers

      # @!attribute version
      # @return [String]
      attribute(:version, kind_of: String, required: true)

      # @!attribute install_method
      # @return [Symbol]
      attribute(:install_method, default: 'binary', equal_to: %w{source binary package})

      # @!attribute install_path
      # @return [String]
      attribute(:install_path, kind_of: String, default: lazy { windows? ? prefix_path : '/srv' })

      # @!attribute config_file
      # @return [String]
      attribute(:config_file, kind_of: String, default: lazy { node['consul']['config']['path'] })

      # @!attribute user
      # @return [String]
      attribute(:user, kind_of: String, default: 'consul')

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'consul')

      # @!attribute environment
      # @return [String]
      attribute(:environment, kind_of: Hash, default: lazy { default_environment })

      # @!attribute package_name
      # @return [String]
      attribute(:package_name, kind_of: String, default: 'consul')

      # @!attribute binary_url
      # @return [String]
      attribute(:binary_url, kind_of: String)

      # @!attribute source_url
      # @return [String]
      attribute(:source_url, kind_of: String)

      # @!attribute data_dir
      # @return [String]
      attribute(:data_dir, kind_of: String, default: lazy { node['consul']['service']['data_dir'] })

      # @!attribute config_dir
      # @return [String]
      attribute(:config_dir, kind_of: String, default: lazy { node['consul']['config']['config_dir'] })

      # @!attribute stdout_path
      # @return [String]
      attribute(:stdout_path, kind_of: String, default: lazy { node['consul']['service']['stdout_path'] })

      # @!attribute stderr_path
      # @return [String]
      attribute(:stderr_path, kind_of: String, default: lazy { node['consul']['service']['stderr_path'] })

      # @!attribute logrotate_frequency
      # @return [String]
      attribute(:logrotate_frequency, kind_of: Integer, default: lazy { node['consul']['service']['logrotate_frequency'] })
    end
  end
end

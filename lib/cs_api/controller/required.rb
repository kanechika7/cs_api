# coding: UTF-8

# 認証系
# @author Nozomu Kanechika
# @from 0.0.1
module CsApi
  module Controller
    module Required
      extend ActiveSupport::Concern

      module InstanceMethods

        # cookie session が入っているかどうか
        # @author Nozomu Kanechika
        # @from 0.0.1
        def cs_required
        end

        # cookie role よりアクセス権限があるか
        # @author Nozomu Kanechika
        # @from 0.0.1
        def cs_role_required
        end

      end

    end
  end
end

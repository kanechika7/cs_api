# coding: UTF-8

# 基本メソッド
# @author Nozomu Kanechika
# @from 0.0.1
module CsApi
  module Model
    module Base
      extend ActiveSupport::Concern

      module ClassMethods

        # index action interface
        # @author Nozomu Kanechika
        # @from 0.0.1
        def index_api pms
          cs = scoped
                 .mongo_scope(pms)
                 .rails_scope(pms)

          return index_data(cs,pms)
        end

        # show action interface       
        # @author Nozomu Kanechika
        # @from 0.0.1
        def show_api pms
          c = where(id: pms[:id])

          return show_data(c,pms)
        end

      end

      module InstanceMethods

        # コピーするカラム
        # @author Nozomu Kanechika
        # @from 0.0.1
        def copy_attributes
          eval("#{self.class.to_s}::Scope::COPYATTRIBUTES").inject({}) do |attrs,name|
            attrs[name] = read_attribute(name)
            attrs
          end
        end

      end
    end
  end
end
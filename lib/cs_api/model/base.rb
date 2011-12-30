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
        def index_api pms,session
          cs = scoped
          cs = cs.cs_scope(session,pms) if include?(CookieSessionScope::Document)
          cs = cs
                 .rails_scope(pms)
                 #.mongo_scope(pms)

          return index_data(cs,pms)
        end

        # show action interface       
        # @author Nozomu Kanechika
        # @from 0.0.1
        def show_api pms,session
          c = where(id: pms[:id])

          return show_data(c,pms)
        end

      end

      module InstanceMethods

        # コピーするカラム
        # @author Nozomu Kanechika
        # @from 0.0.1
        def copy_attributes
          eval("#{self.class.to_s}::COPYATTRIBUTES").inject({}) do |attrs,name|
            attrs[name] = read_attribute(name)
            attrs
          end
        end

      end
    end
  end
end

# coding: UTF-8

# rails フィルター
# @author Nozomu Kanechika
# @from 0.0.1
module CsApi
  module Model
    module Scope
      module RailsScope
        extend ActiveSupport::Concern

        included do

          # rails scope interface
          # @author Nozomu Kanechika
          # @from 0.0.1
          scope :rails_scope ,->(pms) do
            cs = scoped
            cs = cs.page(pms[:page]) unless pms[:page].blank?
            cs = cs.per(pms[:per])   unless pms[:per].blank?
            return cs
          end

        end

      end
    end
  end
end

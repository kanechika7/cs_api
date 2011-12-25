# coding: UTF-8

# スコープ
# @author Nozomu Kanechika
# @from 0.0.1

require 'cs_api/model/scope/mongo_scope' # mongo フィルター
require 'cs_api/model/scope/rails_scope' # rails フィルター

module CsApi
  module Model
    module Scope
      extend ActiveSupport::Concern
      include CsApi::Model::Scope::MongoScope
      include CsApi::Model::Scope::RailsScope
    end
  end
end

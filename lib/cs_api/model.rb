# coding: UTF-8

# modelで定義するもの用
# @author Nozomu Kanechika
# @from 0.0.1

require 'cs_api/model/base'  # 基本メソッド（index_api ,show_api ,copy_attributes）
require 'cs_api/model/data'  # 最終データ加工 
require 'cs_api/model/scope' # スコープ定義

module CsApi
  module Model
    include CsApi::Model::Base
    include CsApi::Model::Data
    include CsApi::Model::Scope
  end
end

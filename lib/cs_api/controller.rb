# coding: UTF-8

# controller で使用するもの
# @author Nozomu Kanechika
# @from 0.0.1

require 'cs_api/controller/required' # 認証系（cs_required、cs_role_required）
require 'cs_api/controller/strut_wrapper' # strutをwrapping

module CsApi
  module Controller
    extend ActiveSupport::Concern
    include CsApi::Controller::Required
    include CsApi::Controller::StrutWrapper
  end
end


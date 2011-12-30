# coding: UTF-8

# fake app
# @author Nozomu Kanechika
# @since 0.0.1
require 'active_record'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'mongoid'

# db
Mongoid.configure do |config|
  name = "mongoid_test"
  config.master = Mongo::Connection.new.db(name)
  config.logger = nil
end

# config
app = Class.new Rails::Application
app.config.secret_token = "3b7cd727ee24e8444053437c36cc66c4"
app.config.session_store :cookie_store, :key => "_myapp_session"
app.config.active_support.deprecation = :log
app.initialize!

# routing
app.routes.draw do
  resources :users do
    member do
      post :copy
    end
  end
end

# models
class User
  include Mongoid::Document
  include CookieSessionScope::Document
  cookie_session_scope 'user_info.sp'

  field :me

  include CsApi::Model
  # index を取得するものを設定
  INDEX_SELECTS = %w(id me)
  INDEX_METHODS = %w()
  # show を取得するものを設定
  SHOW_SELECTS = %w(id me)
  SHOW_METHODS = %w()
  # copy 時にコピーするDBカラム
  COPYATTRIBUTES = %w(me)

end

# controllers
class ApplicationController < ActionController::Base;
  include Strut::Controller
  include CsApi::Controller
end
class UsersController < ApplicationController
  cs_api User
end

#Object.const_set(:ApplicationHelper,Module.new)


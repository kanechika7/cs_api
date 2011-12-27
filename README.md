# 概要
Cookie Session を使ったAPI用に最適化したControllerを自動生成するツールです。

# 機能一覧
1. 認証
  - CookieSession が入ってるかどうか
  - Cookie Role によるアクセス権限
2. スコープ
  - Cookie Scope によるフィルタリング
  - パラメータによるフィルタリング

# 使い方

## ① config 設定

    $ vi confit/envionments/development.rb
    
    $COOKIE_STORE_KEY    = "_qs_api"
    $COOKIE_SECRET_TOKEN = "c4ed0207ff1a6ff6fb0a45a2c9442d6138fbdf20ba52c62b331e7a0348722076ec27d5cadfc367e3428a49b09e70b7dbc5255f6b33e5c7320187e96ce6a6dd23"
    

## ① ルーティング設定

    $ vi config/routes.rb
    
    resouces :MODELS ,only: [:index,:show,:create,:update,:destroy] do
      member do
        post :copy
      end
    end
    

## ② Controller設定

    $ vi app/controllers/application_controller.rb
    
    include Strut::Controller
    include CsApi::Controller
    

    $ vi app/controllers/MODELS_controller.rb
    
    class MODELSController < ApplicationController
      cs_api MODEL
    

## ③ Model設定

    $ vi app/models/MODEL.rb
    
    class MODEL
      include CookieSessionScope::Document
      cookie_session_scope 'user_info.sp'
    

    $ vi app/models/MODEL/scope.rb
    
    class MODEL
      module Scope
        include CsApi::Model
          # index を取得するものを設定
          INDEX_SELECTS = %w(id me)
          INDEX_METHODS = %w()
          # show を取得するものを設定
          SHOW_SELECTS = %w(id me)
          SHOW_METHODS = %w()
          # copy 時にコピーするDBカラム
          COPYATTRIBUTES = %w(me)
    

## ④ リクエスト

URL

    
    GET    ./v1/objects.json           # index
    GET    ./v1/objects/:id.json       # show
    POST   ./v1/objects.json           # create
    PUT    ./v1/objects/:id.json       # update
    DELETE ./v1/objects/:id.json       # destroy
    POST   ./v1/objects/:id/copy.json  # copy
    


パラメータ

    
    index、show にアクセスする時以下のパラメータが使用できる
    
    includes: 関連を取得、複数取得する時はカンマ（,）区切り、多段の時は「->(..)」で指定して取って来れる
    ex.
      includes=unit
      includes=replies->(reply_answers,reply_integers)
    


# coding: UTF-8

# cs_api - cookie session API
#
# 機能
# フィルタリングを提供
# 1. 認証
#   - CookieSession が入ってるかどうか
#   - Cookie Role によるアクセス権限
# 2. スコープ
#   - Cookie Scope によるフィルタリング
#   - パラメータによるフィルタリング
#
# ディレクトリ
#    - cs_api.rb
#    - cs_api/
#      - model.rb # モデルで定義するもの
#      - model/
#        - base.rb  # 基本メソッド（index_api ,show_api ,copy_attributes）
#        - data.rb  # 最終データ加工
#        - scope.rb # スコープ定義
#        - scope/mongo_scope.rb
#        - scope/rails_scope.rb
#      - controller.rb　# controllerで定義するもの
#      - controller/
#        - required.rb # 認証系（cs_required、cs_role_required）
#        - strut_wrapper.rb # strut をwrapping
#
# @author Nozomu Kanechika
# @from 0.0.1
module CsApi
  require File.join(File.dirname(__FILE__), 'cs_api/model')
  require File.join(File.dirname(__FILE__), 'cs_api/controller')
  class CsApi::Error < StandardError; end
end

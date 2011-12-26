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
          return render json: 'cookie session is not exists.' if session['user_info'].nil?
        end

        # cookie role よりアクセス権限があるか
        # @author Nozomu Kanechika
        # @from 0.0.1
        def cs_role_required
          r = JSON.parse(session['user_info'])['roles'].detect{|r| r=~/^#{params[:controller]}-/ }
          return render json: 'your role is not permitted.' if r.nil?
          rs = r.split('-')
          case params[:action]
          when 'index','show'
            return render json: 'your role is not permitted.' unless rs[1]=~/^r/
          when 'create','update','copy','destroy'
            return render json: 'your role is not permitted.' unless rs[1]=='rw'
          else
            return render json: 'your role is not permitted.'
          end
        end

      end

    end
  end
end

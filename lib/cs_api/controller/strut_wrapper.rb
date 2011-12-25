# coding: UTF-8

# strutをwrapping
# @author Nozomu Kanechika
# @from 0.0.1

module CsApi
  module Controller
    module StrutWrapper
      extend ActiveSupport::Concern

      module ClassMethods

        # controller interface
        # @author Nozomu Kanechika
        # @from 0.0.1
        def cs_api clazz, options={}

          table_name = clazz.to_s.tableize.gsub("/","_")
          file_name = clazz.to_s.underscore.gsub("/","_")
          actions = Strut::Model::Holder.new options


          class_eval do
            strut_controller clazz, create: [:copy]
            skip_before_filter :find_one ,only: [:show]
            before_filter :cs_required
            before_filter :cs_role_required
          end

          # index action
          define_method :index do
            respond_index(instance_variable_get("@#{table_name}"),{
              t_json: Proc.new{ render json: clazz.index_api(params,session) }
            })
          end

          # show action
          define_method :show do
            respond_show(instance_variable_get("@#{file_name}"),{
              t_json: Proc.new{ render json: clazz.show_api(params,session) }
            })
          end

          # create action
          define_method :create do
            obj = instance_variable_get("@#{file_name}")
            respond_create(obj,{
              t_json: Proc.new{ render json: obj.as_json(as: :api) ,status: :created }
            })
          end

          # copy action
          define_method :copy do
            obj = instance_variable_get("@#{file_name}")
            obj.attributes = clazz.find(params[:id]).copy_attributes
            respond_create(obj,{
              t_json: Proc.new{ render json: obj.as_json(as: :api) ,status: :created }
            })
          end

          # update action
          define_method :update do
            obj = instance_variable_get("@#{file_name}")
            respond_update(obj,{
              t_json: Proc.new{ render json: obj.as_json(as: :api) }
            })
          end

          # destroy action
          define_method :destroy do
            obj = instance_variable_get("@#{file_name}")
            respond_destroy(obj,{
              t_json: Proc.new{ render json: obj.as_json(as: :api) }
            })
          end

        end

      end

    end
  end
end

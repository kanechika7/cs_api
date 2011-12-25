# coding: UTF-8

# 最終データ加工
# @author Nozomu Kanechika
# @from 0.0.1
module CsApi
  module Model
    module Data
      extend ActiveSupport::Concern
      
      included do

        # scope interface
        # @author Nozomu Kanechika
        # @from 0.0.1
        scope :index_data_filter ,->(pms){ select_index(pms).includes_index(pms) }
        scope :show_data_filter  ,->(pms){ select_show(pms).includes_show(pms) }

        # select scope
        # @author Nozomu Kanechika
        # @from 0.0.1
        scope :select_index   ,->(pms){ select(selects_from_params(pms,'INDEX').join(',')) }
        scope :select_show    ,->(pms){ select(selects_from_params(pms,'SHOW').join(',')) }

        # includes scope
        # @author Nozomu Kanechika
        # @from 0.0.1
        scope :includes_index ,->(pms){ includes(includes_from_params(pms,'INDEX')) }
        scope :includes_show  ,->(pms){ includes(includes_from_params(pms,'SHOW')) }

      end

      module ClassMethods

        # パラメータからincludesするものを取得
        # @author Nozomu Kanechika
        # @from 0.0.1
        def includes_from_params pms,aktion='INDEX'
          includes_parser(pms[:includes])
        end

        # パラメータからselectsするものを取得
        # @author Nozomu Kanechika
        # @from 0.0.1
        def selects_from_params pms,aktion='INDEX'
          pms[:selects].blank? ? eval("#{self.to_s}::Scope::#{aktion}_SELECTS") : ((eval("#{self.to_s}::Scope::#{aktion}_SELECTS") + pms[:selects].split(',').map{|s| s.to_sym }).uniq)
        end

        # パラメータ -> includes パーサー
        # @author Nozomu Kanechika
        # @from 0.0.1
        def includes_parser str
          return [] if str.blank?
          eval(('['+str+']').gsub('-','=').gsub('(','[').gsub(')',']').gsub('[','[:').gsub(',',',:'))
        end

        # index data 加工
        # @author Nozomu Kanechika
        # @from 0.0.1
        def index_data cs,pms={}
          { :current_page => ( cs.current_page if cs.methods.include?(:current_page) ),
            :num_pages    => ( cs.num_pages  if cs.methods.include?(:num_pages) ),
            :first_page?  => ( cs.first_page?  if cs.methods.include?(:first_page?) ),
            :last_page?   => ( cs.last_page?  if cs.methods.include?(:last_page?) ),
            :total_count  => ( cs.total_count  if cs.methods.include?(:total_count) ),
            :rows         => to_index_data(cs.index_data_filter(pms),pms,includes_from_params(pms,'INDEX')) }
        end

        # show data 加工
        # @author Nozomu Kanechika
        # @from 0.0.1
        def show_data c,pms={}
          to_show_data(c.show_data_filter.first,pms,includes_from_params(pms,'SHOW'))
        end

        # index data support
        # @author Nozomu Kanechika
        # @from 0.0.1
        def to_index_data cs,pms={},ins=[]
          cs.map do |c|
            to_one_data c,pms,ins,'INDEX'
          end
        end

        # show data support
        # @author Nozomu Kanechika
        # @from 0.0.1
        def to_show_data c,pms={},ins=[]
          to_one_data c,pms,ins,'SHOW'
        end


        # data 作成
        # @author Nozomu Kanechika
        # @from 0.0.1
        def to_one_data c,pms,ins,aktion
          h = Hash[*((selects_from_params(pms,aktion))+eval("#{self.to_s}::Scope::#{aktion}_METHODS")).map{|f| [f,c.send(f)] }.flatten]
          ins.each do |t|
            if t.is_a? Hash
              t.each_pair do |k,vs|
                k_data = c.send(k)
                if !k_data.blank?
                  if c.methods.include?("#{k}_id".to_sym)
                    k_data = k.to_s.classify.constantize.to_show_data(k_data,{},vs)
                  else
                    k_data = k.to_s.classify.constantize.to_index_data(k_data,{},vs)
                  end
                end
                h.merge!({ k => k_data })
              end
            else
              c_data = c.send(t)
              if !c_data.blank?
                if c.methods.include?("#{t}_id".to_sym)
                  c_data = t.to_s.classify.constantize.to_show_data(c_data)   # belongs_to の場合
                else
                  c_data = t.to_s.classify.constantize.to_index_data(c_data)  # has_many の場合
                end
              end
              h.merge!({ t => c_data })
            end
          end
          return h
        end



      end


    end
  end
end

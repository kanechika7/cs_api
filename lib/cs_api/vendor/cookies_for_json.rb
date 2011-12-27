# coding: UTF-8

# cookie session to json
# @author Nozomu Kanechika
# @since 0.0.1
module ActionDispatch
  class Cookies

    class SignedCookieJar < CookieJar

      # get cookies
      # @author Nozomu Kanehcika
      # @since 0.0.1
      def [](name)
        begin
          if signed_message = @parent_jar[name]
            @verifier.json_verify(signed_message)
            #@verifier.verify(signed_message)
            #original = JSON.parse(signed_message) if signed_message
            #if original.has_key?('flash')
            #  original['flash'] = ActionDispatch::Flash::FlashHash.new.update(Hash[*original['flash'].flatten])
            #end
            #original
          end
        rescue => e
          Rails.logger.debug e.inspect
          nil
        end
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        nil
      end

      # insert cookies
      # @author Nozomu Kanehcika
      # @since 0.0.1
      def []=(key, options)
        raise ClosedError, :cookies if closed?
        if options.is_a?(Hash)
          options.symbolize_keys!
          options[:value] = @verifier.json_generate(options[:value])
          #options[:value] = options[:value].to_json
        else
          options = { :value => @verifier.json_generate(options) }
          #options = { :value => options.to_json }
        end

        raise CookieOverflow if options[:value].size > MAX_COOKIE_SIZE
        @parent_jar[key] = options
      end

    end

  end
end

module ActiveSupport
  class MessageVerifier

    # json verify
    # @author Nozomu Kanehcika
    # @since 0.0.1
    def json_verify(signed_message)
      raise InvalidSignature if signed_message.blank?

      data, digest = signed_message.split("--")
      if data.present? && digest.present? && secure_compare(digest, generate_digest(data))
        #Marshal.load(ActiveSupport::Base64.decode64(data))
        original = ::JSON.parse(ActiveSupport::Base64.decode64(data))
        if original.has_key? 'flash'
          original['flash'] = ActionDispatch::Flash::FlashHash.new.update(Hash[*original['flash'].flatten])
        end
        original
      else
        raise InvalidSignature
      end
    end

    # json generate
    # @author Nozomu Kanehcika
    # @since 0.0.1
    def json_generate(value)
      #data = ActiveSupport::Base64.encode64s(Marshal.dump(value))
      data = ActiveSupport::Base64.encode64s(value.to_json)
      "#{data}--#{generate_digest(data)}"
    end


  end
end


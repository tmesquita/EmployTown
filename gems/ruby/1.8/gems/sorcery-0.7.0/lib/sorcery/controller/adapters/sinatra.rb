module Sorcery
  module Controller
    module Adapters
      # This module does the magic of translating Rails commands to Sinatra.
      # This way the Rails code doesn't change, but it actually now calls Sinatra calls.
      module Sinatra
        def self.included(base)
          base.class_eval do
            class << self
              # prepend a filter
              def prepend_filter(type, path = nil, options = {}, &block)
                return filters[type].unshift block unless path
                path, options = //, path if path.respond_to?(:each_pair)
                block, *arguments = compile!(type, path, block, options)
                prepend_filter(type) do
                  process_route(*arguments) { instance_eval(&block) }
                end
              end

              def after_filter(filter)
                after do
                  send(filter)
                end
              end
            end
          end

          ::Sinatra::Request.class_eval do
            def authorization
              env['HTTP_AUTHORIZATION'] ||
                  env['X-HTTP_AUTHORIZATION'] ||
                  env['X_HTTP_AUTHORIZATION'] ||
                  env['REDIRECT_X_HTTP_AUTHORIZATION'] || nil
            end
          end

          base.send(:include, SorceryHelpers)
          base.send(:include, InstanceMethods)
          base.extend(ClassMethods)
        end

        module SorceryHelpers

          def request_http_basic_authentication(realm)
            response.header['WWW-Authenticate'] = %(Basic realm="#{realm}")
            response.status = 401
          end

          def authenticate_with_http_basic(&blk)
            @auth ||= Rack::Auth::Basic::Request.new(request.env)
            yield @auth.credentials if (@auth.provided? && @auth.basic? && @auth.credentials)
          end

        end

        module InstanceMethods
          def reset_session
            session.clear
          end

          def redirect_to(*args)
            args.pop if args.last.is_a?(Hash)
            redirect(*args)
          end

          def root_path
            '/'
          end

          ::Sinatra.helpers do
            include SorceryHelpers
          end

          def cookies
            @cookie_proxy ||= CookieProxy.new(request, response)
          end
        end

        class CookieProxy
          def initialize(request, response)
            @request = request
            @response = response
            @secure = false
          end

          def [](key)
            value = @request.cookies[key.to_s]
          end

          def []=(key, value)
            if @secure
              value.merge(:secret => Config.sinatra_cookie_secret)
              @secure = false
            end
            @response.set_cookie(key, value)
          end
          
          # mark cookie as signed, which will light a flag, which will cause the next set_cookie to be encrypted.
          def signed
            @secure = true
            self
          end
        end

        module ClassMethods
          def prepend_before_filter(filter)
            prepend_filter(:before) do
              send(filter)
            end
          end
        end
      end
    end
  end
end
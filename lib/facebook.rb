$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Facebook

  autoload :Album, "facebook/album"
  autoload :Event, "facebook/event"
  autoload :Page,  "facebook/page"
  autoload :Photo, "facebook/photo"
  autoload :Post,  "facebook/post"
  autoload :User,  "facebook/user"

  class GraphObject < Struct.new(:data)
    def initialize(data)
      self.data = data
    end

    def id
      data["id"]
    end

    def name
      data["name"]
    end

    def upated_at
      Time.zone.parse data["updated_time"]
    end

    def path
      "#{self.class.resource_name}/#{id}/#{name.parameterize}"
    end

    class << self

      def resource_name
        to_s.demodulize.underscore.pluralize
      end

      def cache_key(key)
        "fb_cache:#{resource_name}:#{key}"
      end

      def cache_write(key, data)
        settings.redis.set(key, data.to_json)
        settings.redis.expire(key, settings.cache_ttl)
        data
      end

      def cache_read(key)
        cached = settings.redis.get(key)
        cached ? JSON.parse(cached) : nil
      end

      def cache(key)
        key = cache_key(key)
        cached = cache_read(key)

        if cached
          ap "Cache: use cached version of #{key}"
          return cached
        end

        ap "Cache: can't find #{key}, retrieving new"
        cache_write(key, yield)
      end

      def graph
        return @@graph if defined?(@@graph)
        oauth = Koala::Facebook::OAuth.new(settings.facebook["app_id"], settings.facebook["app_secret"])
        access_token = oauth.get_app_access_token
        @@graph = Koala::Facebook::API.new(access_token)
      end

    end
  end
end






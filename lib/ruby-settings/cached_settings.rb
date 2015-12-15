module RubySettings
  class CachedSettings < Settings 
    after_update :rewrite_cache    
    after_create :rewrite_cache
    after_destroy :expire_cache 

    include RubySettings::ConfigurationHelpers

    def rewrite_cache
      cache_store.write(cache_key, value)
    end

    def expire_cache
      cache_store.delete(cache_key)
    end

    def cache_key
      self.class.cache_key(var, thing)
    end

    class << self
    
      include RubySettings::ConfigurationHelpers
      
      def cache_prefix(&block)
        @cache_prefix = block
      end

      def cache_key(var_name, scope_object)
        scope = "rails_settings_cached:"
        scope << "#{@cache_prefix.call}:" if @cache_prefix
        scope << "#{scope_object.class.name}-#{scope_object.id}:" if scope_object
        scope << "#{var_name}"
      end

      def [](var_name)
        value = cache_store.fetch(cache_key(var_name, @object)) do
          super(var_name)
        end

        if value.nil?
          @@defaults[var_name.to_s] if value.nil?
        else
          value
        end
      end

      def save_default(key, value)
        return false unless self[key].nil?
        self[key] = value
      end
    end
  end
end

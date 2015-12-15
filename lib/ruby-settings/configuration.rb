module RubySettings

  class << self

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end

  end

  class Configuration
    attr_accessor :cache_store
  end

  module ConfigurationHelpers
    extend ActiveSupport::Concern

    def cache_store
      @cache_store ||= (RubySettings.config.cache_store || (defined?(Rails) ? Rails.cache : ActiveSupport::Cache::MemoryStore.new))
    end

  end
end


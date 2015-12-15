require 'rspec'
require 'active_record'
require 'active_support'
require 'sqlite3'

require_relative '../lib/ruby-settings/settings.rb'


if RubySettings::Settings.respond_to? :raise_in_transactional_callbacks=
  RubySettings::Settings.raise_in_transactional_callbacks = true
end
require_relative '../lib/ruby-settings-cached'


RubySettings.configure do |config|
  config.cache_store = ActiveSupport::Cache::MemoryStore.new
end


def count_queries &block
  count = 0

  counter_f = ->(name, started, finished, unique_id, payload) {
    unless %w[ CACHE SCHEMA ].include?(payload[:name])
      count += 1
    end
  }

  ActiveSupport::Notifications.subscribed(counter_f, "sql.active_record", &block)

  count
end


# ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
# ActiveRecord::Base.configurations = true

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(version: 1) do
  create_table :settings do |t|
    t.string :var, null: false
    t.text :value
    t.integer :thing_id
    t.string :thing_type, limit: 30
    t.datetime :created_at
    t.datetime :updated_at
  end

  create_table :users do |t|
    t.string :login
    t.string :password
    t.datetime :created_at
    t.datetime :updated_at
  end
end

RSpec.configure do |config|
  config.before(:all) do
    class Setting < RubySettings::CachedSettings
    end

    class CustomSetting < RubySettings::CachedSettings
      table_name = 'custom_settings'
    end

    class User < ActiveRecord::Base
      include RubySettings::Extend
    end

    ActiveRecord::Base.connection.execute('delete from settings')
    RubySettings.config.cache_store.clear
  end

  config.after(:all) do
    Object.send(:remove_const, :Setting)
  end
end

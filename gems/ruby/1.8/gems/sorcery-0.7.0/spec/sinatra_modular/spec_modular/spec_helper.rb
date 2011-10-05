require File.join(File.dirname(__FILE__), '..', 'modular.rb')
$: << APP_ROOT # for model reloading

require 'rack/test'
require 'rspec'
require 'timecop'

# set test environment
Modular.class_eval do
  set :environment, :test
  set :run, false
  set :raise_errors, true
  set :logging, false
  set :lock, true
  set :show_exceptions, true
end


module RSpecMixinExample
  include Rack::Test::Methods

  def app
    @app ||= Modular
  end
end

Rspec.configure do |config|
  config.send(:include, RSpecMixinExample)
  config.send(:include, ::Sorcery::TestHelpers::Internal)
  config.send(:include, ::Sorcery::TestHelpers::Internal::SinatraModular)
  config.before(:suite) do
    ActiveRecord::Migrator.migrate("#{APP_ROOT}/db/migrate/core")
  end

  config.after(:suite) do
    ActiveRecord::Migrator.rollback("#{APP_ROOT}/db/migrate/core")
  end

end

# needed when running individual specs
require File.join(File.dirname(__FILE__), '..', 'user')
require File.join(File.dirname(__FILE__), '..', 'authentication')

class TestUser < ActiveRecord::Base
  authenticates_with_sorcery!
end

class TestMailer < ActionMailer::Base

end
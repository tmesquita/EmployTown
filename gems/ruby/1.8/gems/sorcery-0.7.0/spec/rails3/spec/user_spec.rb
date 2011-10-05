require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../app/mailers/sorcery_mailer')
require File.expand_path(File.dirname(__FILE__) + '/../../shared_examples/user_shared_examples')

describe "User with no submodules (core)" do
  before(:all) do
    sorcery_reload!
  end

  describe User, "when app has plugin loaded" do
    it "should respond to the plugin activation class method" do
      ActiveRecord::Base.should respond_to(:authenticates_with_sorcery!)
    end
    
    it "User should respond_to .authenticates_with_sorcery!" do
      User.should respond_to(:authenticates_with_sorcery!)
    end
  end
  
  # ----------------- PLUGIN CONFIGURATION -----------------------

  it_should_behave_like "rails_3_core_model"
  
  describe User, "external users" do
    before(:all) do
      ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate/external")
      sorcery_reload!()
    end
  
    after(:all) do
      ActiveRecord::Migrator.rollback("#{Rails.root}/db/migrate/external")
    end
    
    it_should_behave_like "external_user"
  end
end
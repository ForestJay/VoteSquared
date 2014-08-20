ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Drop all collections after each test case.
  def teardown
    MongoMapper.database.collections.each do |coll|
      coll.remove
    end
  end
 
 # Make sure that each test case has a teardown
 # method to clear the db after each test.
 def inherited(base)
   base.define_method :teardown do
     super
   end
 end
end

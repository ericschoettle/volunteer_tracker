require './lib/project'
require './lib/volunteer'
require './lib/leader'
require './lib/helper'
require 'pry'
require 'pg'


DB = PG.connect({:dbname => "volunteer_tracker_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM volunteers *;")
    DB.exec("DELETE FROM projects *;")
    DB.exec("DELETE FROM projects_volunteers *;")
    DB.exec("DELETE FROM leaders *;")
  end
end

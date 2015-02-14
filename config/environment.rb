# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Myheadway::Application.initialize!

Rails::Timeago.default_options :limit => proc { 20.days.ago }, :force => true, :nojs => true, :date_only =>false 
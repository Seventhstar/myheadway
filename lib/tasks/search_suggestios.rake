namespace :search_suggestions do
  desc "generate search suggestions from statements"
  task :index => :environment do
    SearchSuggestion.index_statements
  end
end
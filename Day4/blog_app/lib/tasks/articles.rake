namespace :articles do
  desc "Remove articles reported 6 or more times"
  task remove_reported: :environment do
    Article.where("reports_count >= ?", 6).destroy_all
    puts "Removed articles with 6 or more reports."
  end
end
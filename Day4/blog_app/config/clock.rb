require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    case job
    when 'remove_reported_articles'
      Article.where("reports_count >= ?", 6).destroy_all
      Rails.logger.info "Removed articles with 6 or more reports at #{Time.current}"
    end
  end

  every(5.minutes, 'remove_reported_articles')
end
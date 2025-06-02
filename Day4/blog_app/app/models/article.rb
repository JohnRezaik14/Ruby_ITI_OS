# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  body          :text
#  img           :string
#  reports_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Article < ApplicationRecord
end

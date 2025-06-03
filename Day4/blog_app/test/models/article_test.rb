# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  archived      :boolean          default(FALSE)
#  body          :text
#  image         :string
#  reports_count :integer
#  status        :string           default("published")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

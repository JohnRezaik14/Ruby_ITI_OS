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
class Article < ApplicationRecord
  belongs_to :user
  mount_uploader :image, PostImageUploader
  
  validates :body, presence: true
  validates :user, presence: true
  validate :validate_image
  
  after_save :archive_if_reported
  
  scope :published, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  
  def report!
    increment!(:reports_count)
  end
  
  private
  
  def archive_if_reported
    update_column(:archived, true) if reports_count.to_i >= 3 && !archived?
  end

  def validate_image
    if image.present?
      unless image.content_type.in?(%w(image/jpeg image/png image/gif image/webp))
        errors.add(:image, 'must be a JPG, PNG, GIF, or WEBP image')
      end
      
      if image.size > 5.megabytes
        errors.add(:image, 'size must be less than 5MB')
      end
    end
  end
end

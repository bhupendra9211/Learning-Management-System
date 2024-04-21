class Lesson < ApplicationRecord
  has_one_attached :video do |attachable|
    attachable.variant :thumb, resize_to_limit: [500,500]
  end
  has_rich_text :description
  belongs_to :course
  has_many :lesson_users, dependent: :destroy
end

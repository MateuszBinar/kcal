class Entry < ApplicationRecord

  validates :calories, :proteins, :carbohydrates, :fats, :meal_type, presence: true
  
  def day
    self.created_at.strftime("%b %e, %Y")
  end

  belongs_to :user
  has_one :photo
  accepts_nested_attributes_for :photo
end

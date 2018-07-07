class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :overview, presence: true
  validates :isbn, presence: true
  validates :released_at, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
end

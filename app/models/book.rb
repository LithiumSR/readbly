class Book < ApplicationRecord
  has_many :reservations, :dependent => :delete_all
  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :overview, presence: true
  validates :isbn, presence: true
  validates :released_at, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
  validate :check_length
  after_create :assign_default_values

  def assign_default_values
    self.isDisabled = false
    self.save
  end

  def check_length
    if isbn.nil?
      errors.add(:Isbn, "Can't be left blank") and return
    end
    unless isbn.gsub(" ","").size == 10 or isbn.gsub(" ","").size == 13
      errors.add(:Isbn, "length must be 10 or 13")
    end
  end

end

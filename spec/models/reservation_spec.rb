require 'rails_helper'

RSpec.describe Reservation, type: :model do

  describe "Create a reservation with an nonexistent user id " do
    it "shouldn't be permitted" do
      book = create(:book)
      expect{Reservation.create!(book_id: book.id, user_id: 0)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "Create a reservation with an nonexistent book id " do
    it "shouldn't be permitted" do
      user = create(:user)
      expect{Reservation.create!(book_id: 0, user_id: user.id)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end


  describe "Create a reservation with an empty book_id " do
    it "should be permitted" do
      user = build(:user)
      res = Reservation.create(user_id: user.id)
      expect(res).to_not be_valid
    end
  end

  describe "Create a reservation with an empty user_id " do
    it "should be permitted" do
      book = build(:book)
      res = Reservation.create(book_id: book.id)
      expect(res).to_not be_valid
    end
  end

  describe "Create a reservation with a valid user.id and book.id " do
    it "should be permitted" do
      user = create(:user)
      book = create(:book)
      expect{Reservation.create!(book_id: book.id, user_id: user.id)}.to_not raise_error
    end
  end

end


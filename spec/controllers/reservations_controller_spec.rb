require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do

  def get_attributes(obj)
    attr = obj.attributes
    attr['updated_at'] = attr['updated_at'].change(:usec => 0)
    attr['created_at'] = attr['created_at'].change(:usec => 0)
    attr
  end

  describe "POST #create_reservation " do
    context "as a basic user with valid book id and user id"  do
      login_user
      it "should create a reservation" do
        book = create(:book)
        post :create, params: {:book_id =>  book.id, :user_id => subject.current_user.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to_not eq(true)
      end
    end

    context "as an operator with valid book id and user id"  do
      login_operator
      it "should create a reservation" do
        book = create(:book)
        post :create, params: {:book_id =>  book.id, :user_id => subject.current_user.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to_not eq(true)
      end
    end

    context "as an admin with valid book id and user id"  do
      login_admin
      it "should create a reservation" do
        book = create(:book)
        post :create, params: {:book_id =>  book.id, :user_id => subject.current_user.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to_not eq(true)
      end
    end

    context "as an not signed-in user with valid book id and user id"  do
      it "shouldn't create a reservation" do
        book = create(:book)
        user = create(:user)
        post :create, params: {:book_id =>  book.id, :user_id => user.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(true)
      end
    end

    context "as an admin with a non existent book id and a valid user id"  do
      login_admin
      it "should raise a ActiveRecord::RecordInvalid error" do
        expect{post :create, params: {:book_id =>  -1, :user_id => subject.current_user.id}}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "as an admin with a valid book id and a non existent user id"  do
      login_admin
      it "should raise a ActiveRecord::RecordInvalid error" do
        book = create(:book)
        expect{post :create, params: {:book_id =>  book.id, :user_id => -1}}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "as an admin with a valid book id and an user id that's not mine"  do
      login_admin
      it "should create a reservation" do
        book = create(:book)
        user = create(:user)
        post :create, params: {:book_id =>  book.id, :user_id => user.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to_not eq(true)
      end
    end

    context "as an operator with a valid book id and an user id that's not mine"  do
      login_operator
      it "shouldn't create a reservation" do
        book = create(:book)
        user = create(:user)
        post :create, params: {:book_id =>  book.id, :user_id => user.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(true)
      end
    end

    context "as a basic user with a valid book id and an user id that's not mine"  do
      login_user
      it "shouldn't create a reservation" do
        book = create(:book)
        user = create(:user)
        post :create, params: {:book_id =>  book.id, :user_id => user.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(true)
      end
    end
  end

  describe "DELETE #delete " do
    context "as a basic user with his own reservation id"  do
      login_user
      it "should delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(true)
      end
    end

    context "as a basic user with a reservation id of another user"  do
      login_user
      it "shouldn't delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(false)
      end
    end

    context "as an operator with the id of his own pending reservation"  do
      login_operator
      it "should delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(true)
      end
    end

    context "as an operator with the id of a pending reservation of another user"  do
      login_operator
      it "should delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(true)
      end
    end

    context "as an admin with the id of his own pending reservation"  do
      login_admin
      it "should delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(true)
      end
    end

    context "as an admin with the id of a pending reservation of another user"  do
      login_admin
      it "should delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(true)
      end
    end

    context "as a basic user with his own active reservation id"  do
      login_user
      it "shouldn't delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(false)
      end
    end

    context "as a basic user with an id of an active reservation of another user"  do
      login_user
      it "shouldn't delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(false)
      end
    end

    context "as an operator with the id of his own pending active reservation"  do
      login_operator
      it "shouldn't delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(false)
      end
    end

    context "as an operator with the id of an active reservation of another user"  do
      login_operator
      it "shouldn't delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(false)
      end
    end

    context "as an admin with the id of his own active reservation"  do
      login_admin
      it "should delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(true)
      end
    end

    context "as an admin with the id of an active reservation of another user"  do
      login_admin
      it "should delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(true)
      end
    end

    context "as a basic user with his own completed reservation id"  do
      login_user
      it "shouldn't delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(false)
      end
    end

    context "as a basic user with an id of an completed reservation of another user"  do
      login_user
      it "shouldn't delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(false)
      end
    end

    context "as an operator with the id of his own pending completed reservation"  do
      login_operator
      it "shouldn't delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(false)
      end
    end

    context "as an operator with the id of an completed reservation of another user"  do
      login_operator
      it "shouldn't delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(false)
      end
    end

    context "as an admin with the id of his own completed reservation"  do
      login_admin
      it "should delete the reservation" do
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => subject.current_user.id).blank?).to eq(true)
      end
    end

    context "as an admin with the id of an completed reservation of another user"  do
      login_admin
      it "should delete the reservation" do
        user = create(:user)
        book = create(:book)
        reservation = Reservation.create!(:book_id => book.id, :user_id => user.id)
        reservation.isLoan = true
        reservation.expiration_date = DateTime.now + 1.month
        reservation.save
        delete :destroy, params: {:id => reservation.id}
        expect(Reservation.find_by(:book_id => book.id, :user_id => user.id).blank?).to eq(true)
      end
    end

    context "as a basic user with the id of a non existent reservation"  do
      login_user
      it "should raise an exception" do
        expect{delete :destroy, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "as an operator with the id of a non existent reservation"  do
      login_operator
      it "should raise an exception" do
        expect{delete :destroy, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "as an admin with the id of a non existent reservation"  do
      login_admin
      it "should raise an exception" do
        expect{delete :destroy, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "PUT #confirm_loan " do
    context "as a basic user with a valid id of a pending reservation"  do
      login_user
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an operator with a valid id of a pending reservation"  do
      login_operator
      it "should change reservation attributes" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to_not eq(old_attr)
      end
    end

    context "as an admin with a valid id of a pending reservation"  do
      login_admin
      it "should change reservation attributes" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to_not eq(old_attr)
      end
    end

    context "as a basic user with a valid id of an active reservation"  do
      login_user
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an operator with a valid id of a active reservation"  do
      login_operator
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an admin with a valid id of a active reservation"  do
      login_admin
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as a basic user with a valid id of a completed reservation"  do
      login_user
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.isReturned = true
        res.returned_date = DateTime.now + 20.day
        res.save
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an operator with a valid id of a completed reservation"  do
      login_operator
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.isReturned = true
        res.returned_date = DateTime.now + 20.day
        res.save
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an admin with a valid id of a completed reservation"  do
      login_admin
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.isReturned = true
        res.returned_date = DateTime.now + 20.day
        res.save
        old_attr = get_attributes res
        put :confirm_loan, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as a basic user with an invalid of a reservation"  do
      login_user
      it "should raise an ActiveRecord::RecordNotFound error" do
        put :confirm_loan, params: {:id => -1}
        assert_redirected_to root_path alert: "User not enabled to manage reservations"
      end
    end

    context "as an operator with an invalid of a reservation"  do
      login_operator
      it "should raise an ActiveRecord::RecordNotFound error" do
        expect{put :confirm_loan, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "as an admin with an invalid of a reservation"  do
      login_admin
      it "should raise an ActiveRecord::RecordNotFound error" do
        expect{put :confirm_loan, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end



  describe "PUT #confirm_return " do
    context "as a basic user with a valid id of an active reservation"  do
      login_user
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_attr = get_attributes res
        put :confirm_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an operator with a valid id of an active reservation"  do
      login_operator
      it "should mark the reservation as completed/returned" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        put :confirm_return, params: {:id => res.id}
        expect(Reservation.find(res.id).isReturned).to eq(true)
      end
    end

    context "as an admin with a valid id of an active reservation"  do
      login_admin
      it "should mark the reservation as completed/returned" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        put :confirm_return, params: {:id => res.id}
        expect(Reservation.find(res.id).isReturned).to eq(true)
      end
    end

    context "as a basic user with a valid id of a pending reservation"  do
      login_user
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        old_attr = get_attributes res
        put :confirm_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an operator with a valid id of a pending reservation"  do
      login_operator
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        old_attr = get_attributes res
        put :confirm_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an admin with a valid id of a pending reservation"  do
      login_admin
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        old_attr = get_attributes res
        put :confirm_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as a basic user with a valid id of a completed reservation"  do
      login_user
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.isReturned = true
        res.returned_date = DateTime.now + 20.day
        res.save
        old_attr = get_attributes res
        put :confirm_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an operator with a valid id of a completed reservation"  do
      login_operator
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.isReturned = true
        res.returned_date = DateTime.now + 20.day
        res.save
        old_attr = get_attributes res
        put :confirm_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an admin with a valid id of a completed reservation"  do
      login_admin
      it "shouldn't make any changes to the reservation" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.isReturned = true
        res.returned_date = DateTime.now + 20.day
        res.save
        old_attr = get_attributes res
        put :confirm_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as a not signed in user with a valid reservation id"  do
      it "should redirect to sign in page" do
        book = create(:book)
        user = create(:user)
        res = Reservation.create!(:book_id => book.id, :user_id => user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        put :confirm_return, params: {:id => res.id}
        assert_redirected_to user_session_url
      end

      it "should remain unchanged" do
        book = create(:book)
        user = create(:user)
        res = Reservation.create!(:book_id => book.id, :user_id => user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_attr = get_attributes res
        put :postpone_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as a basic user with an invalid reservation id"  do
      login_user
      it "should raise an ActiveRecord::RecordNotFound error" do
        put :confirm_return, params: {:id => -1}
        assert_redirected_to root_path alert: "User not enabled to manage reservations"
      end
    end

    context "as an operator with an invalid reservation id"  do
      login_operator
      it "should raise an ActiveRecord::RecordNotFound error" do
        expect{put :confirm_return, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "as an admin with an invalid reservation id"  do
      login_admin
      it "should raise an ActiveRecord::RecordNotFound error" do
        expect{put :confirm_return, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end


  describe "PUT #postpone_return " do
    context "as a basic user with a valid id of an active reservation that wasn't already postponed with the date of expiration near (<=7 days from now)"  do
      login_user
      it "should postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 6.days
        old_exp = res.expiration_date
        res.save
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp))).to eq(true)
      end
    end

    context "as a basic user with a valid id of an active reservation that belongs to another user and that wasn't already postponed with the date of expiration near (<=7 days from now)"  do
      login_user
      it "shouldn't postpone the expiration date" do
        book = create(:book)
        user = create(:user)
        res = Reservation.create!(:book_id => book.id, :user_id => user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 7.days
        old_exp = res.expiration_date
        res.save
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed == false and res.expiration_date.eql?(old_exp))).to eq(true)
      end
    end

    context "as a basic user with a valid id of an active reservation that wasn't already postponed with the date of expiration not near (>=7 days from now)"  do
      login_user
      it "shouldn't postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_attr = get_attributes res
        put :postpone_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as a basic user with a valid id of an active reservation that was already postponed with the date of expiration near (<=7 days from now)"  do
      login_user
      it "shouldn't postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.isPostponed = true
        res.expiration_date = DateTime.now + 7.days
        res.save
        old_attr = get_attributes res
        put :postpone_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as a not signed in user with a valid reservation id"  do
      it "should redirect to sign in page" do
        book = create(:book)
        user = create(:user)
        res = Reservation.create!(:book_id => book.id, :user_id => user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        put :postpone_return, params: {:id => res.id}
        assert_redirected_to user_session_url
      end
      it "should remain unchanged" do
        book = create(:book)
        user = create(:user)
        res = Reservation.create!(:book_id => book.id, :user_id => user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_attr = get_attributes res
        put :postpone_return, params: {:id => res.id}
        expect(get_attributes Reservation.find(res.id)).to eq(old_attr)
      end
    end

    context "as an operator user with a valid id of an active reservation that wasn't already postponed with the date of expiration near (<=7 days from now)"  do
      login_operator
      it "should postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 7.days
        old_exp = res.expiration_date
        res.save
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp))).to eq(true)
      end
    end

    context "as an operator with a valid id of an active reservation that belongs to another user and that wasn't already postponed with the date of expiration near (<=7 days from now)"  do
      login_operator
      it "should postpone the expiration date" do
        book = create(:book)
        user = create(:user)
        res = Reservation.create!(:book_id => book.id, :user_id => user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 7.days
        old_exp = res.expiration_date
        res.save
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp))).to eq(true)
      end
    end

    context "as an operator with a valid id of an active reservation that wasn't already postponed with the date of expiration not near (>=7 days from now)"  do
      login_operator
      it "should postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_exp = res.expiration_date
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp))).to eq(true)
      end
    end

    context "as an operator with a valid id of an active reservation that was already postponed (less than 3 times)"  do
      login_operator
      it "should postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.isPostponed = true
        res.expiration_date = DateTime.now + 1.month
        res.postpone_counter = 2
        res.save
        old_exp = res.expiration_date
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp) and res.postpone_counter == 3)).to eq(true)
      end
    end

    context "as an operator with a valid id of an active reservation that was already postponed 3 times"  do
      login_operator
      it "shouldn't postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.isPostponed = true
        res.expiration_date = DateTime.now + 1.month
        res.postpone_counter = 3
        old_exp = res.expiration_date
        res.save
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect(res.expiration_date.eql?(old_exp)).to eq(true)
      end
    end


    context "as an admin user with a valid id of an active reservation that wasn't already postponed with the date of expiration near (<=7 days from now)"  do
      login_admin
      it "should postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 7.days
        old_exp = res.expiration_date
        res.save
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp))).to eq(true)
      end
    end

    context "as an admin with a valid id of an active reservation that belongs to another user and that wasn't already postponed with the date of expiration near (<=7 days from now)"  do
      login_admin
      it "should postpone the expiration date" do
        book = create(:book)
        user = create(:user)
        res = Reservation.create!(:book_id => book.id, :user_id => user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 7.days
        old_exp = res.expiration_date
        res.save
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp))).to eq(true)
      end
    end

    context "as an admin with a valid id of an active reservation that wasn't already postponed with the date of expiration not near (>=7 days from now)"  do
      login_admin
      it "should postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.expiration_date = DateTime.now + 1.month
        res.save
        old_exp = res.expiration_date
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp))).to eq(true)
      end
    end

    context "as an admin with a valid id of an active reservation that was already postponed (less than 3 times)"  do
      login_admin
      it "should postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.isPostponed = true
        res.expiration_date = DateTime.now + 1.month
        res.postpone_counter = 2
        res.save
        old_exp = res.expiration_date
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((res.isPostponed and !res.expiration_date.eql?(old_exp) and res.postpone_counter == 3)).to eq(true)
      end
    end

    context "as an admin with a valid id of an active reservation that was already postponed 3 times"  do
      login_admin
      it "should postpone the expiration date" do
        book = create(:book)
        res = Reservation.create!(:book_id => book.id, :user_id => subject.current_user.id)
        res.isLoan = true
        res.isPostponed = true
        res.expiration_date = DateTime.now + 1.month
        res.postpone_counter = 3
        old_exp = res.expiration_date
        res.save
        put :postpone_return, params: {:id => res.id}
        res = Reservation.find(res.id)
        expect((!res.expiration_date.eql?(old_exp) and res.postpone_counter==4)).to eq(true)
      end
    end

    context "as an admin with an invalid reservation id"  do
      login_admin
      it "shouldn't postpone the expiration date" do
        expect{put :postpone_return, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "as an operator with an invalid reservation id"  do
      login_operator
      it "shouldn't postpone the expiration date" do
        expect{put :postpone_return, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "as an user with an invalid reservation id"  do
      login_user
      it "shouldn't postpone the expiration date" do
        expect{put :postpone_return, params: {:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe ManagementUsersController, type: :controller do
  describe "GET #change_role " do
    context "as an admin with valid user.id and a new role"  do
      login_admin
      it "change the role of the user.id" do
        user = create(:user)
        get :change_role, params: {:id =>  user.id, :changes => {:role => 'Admin'} }
        result = true
        if !user.has_role?(:admin)
          result = false
        end
        for role in User::ROLES
          if role!=:admin and user.has_role?(role)
            result = false
          end
        end
        expect(result).to eq(true)
      end
    end

    context "as an operator with valid user.id and a new role"  do
      login_operator
      it "should redirect to the root path and the user role should not change" do
        user = create(:user)
        get :change_role, params: {:id =>  user.id, :changes => {:role => 'Admin'} }
        expect(user.has_role?(:admin)).to eq(false) and expect(response.status).to eq(302)
      end
    end

    context "as a basic user with valid user.id and a new role"  do
      login_user
      it "should redirect to the root path and the user role should not change" do
        user = create(:user)
        get :change_role, params: {:id =>  user.id, :changes => {:role => 'Admin'} }
        expect(user.has_role?(:admin)).to eq(false) and expect(response.status).to eq(302)
      end
    end

    context "as a not signed-in user with valid user.id and a new role"  do
      it "should redirect to the sign-in page" do
        user = create(:user)
        get :change_role, params: {:id =>  user.id, :changes => {:role => 'Admin'} }
        assert_redirected_to user_session_url
      end
    end

    context "as an admin with a non existent user.id param and a new role"  do
      login_admin
      it "should raise an ActiveRecord::RecordNotFound error" do
        expect{get :change_role, params: {:id =>  -1, :changes => {:role => 'Admin'} }}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "as an admin with a valid user.id param and a non existent new role"  do
      login_admin
      it "should not apply the new role" do
        user = create(:user)
        get :change_role, params: {:id =>  user.id, :changes => {:role => :invalidRole} }
        expect(user.has_role?(:invalidRole)).to_not eq(true)
      end
    end
  end
end

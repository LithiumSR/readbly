require 'rails_helper'

RSpec.describe ManagementUsersController, type: :controller do

  def get_attributes(obj)
    attr = obj.attributes
    if(!attr['updated_at'].nil?)
      attr['updated_at'] = attr['updated_at'].change(:usec => 0)
    end
    if(!attr['created_at'].nil?)
      attr['created_at'] = attr['created_at'].change(:usec => 0)
    end
    attr
  end

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

      it "user should remain unchanged" do
        user = create(:user)
        old_attr = get_attributes user
        get :change_role, params: {:id =>  user.id, :changes => {:role => 'Admin'} }
        expect(get_attributes User.find(user.id)).to eq(old_attr)
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

  describe "DELETE #destroy " do
    context "as an admin with valid user.id"  do
      login_admin
      it "should delete the user" do
        user = create(:user)
        delete :destroy, params: {:id =>  user.id}
        expect(User.find_by(:id => user.id)).to eq(nil)
      end
    end

    context "as an operator with valid user.id"  do
      login_operator
      it "shouldn't delete the user" do
        user = create(:user)
        delete :destroy, params: {:id =>  user.id}
        expect(User.find_by(:id => user.id)).to_not eq(nil)
      end
    end

    context "as a basic user with valid user.id"  do
      login_user
      it "shouldn't delete the user" do
        user = create(:user)
        delete :destroy, params: {:id =>  user.id}
        expect(User.find_by(:id => user.id)).to_not eq(nil)
      end
    end

    context "as a not signed-in user with valid user.id"  do
      it "should redirect to the sign-in page" do
        user = create(:user)
        delete :destroy, params: {:id =>  user.id}
        assert_redirected_to user_session_url
      end

      it "user shouldn't be deleted" do
        user = create(:user)
        delete :destroy, params: {:id =>  user.id}
        expect(User.find_by(:id => user.id)).to_not eq(nil)
      end
    end

    context "as an admin with a non existent user.id"  do
      login_admin
      it "should raise an ActiveRecord::RecordNotFound error" do
        expect{delete :destroy, params: {:id =>  -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

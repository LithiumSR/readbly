require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe "GET #index " do
    context "when logged in"  do
      login_user
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end
    context "when not logged in" do
      describe "GET #index without a logged account" do
        it "redirects to sign_in page" do
          get :index
          assert_redirected_to user_session_url
        end
    end
    end
  end

  describe "POST #create" do
    context "as an operator with valid params" do
      login_operator
      it "should increment book count by one" do
          before = Book.all.length
          post :create, params: {:book => attributes_for(:book)}
          after = Book.all.length
          expect(before<after).to eq(true)
      end
    end

    context "as an admin with valid params" do
      login_admin
      it "should increment book count by one" do
        before = Book.all.length
        post :create, params: {:book => attributes_for(:book)}
        after = Book.all.length
        expect(before<after).to eq(true)
      end
    end

    context "as a basic user with valid params" do
      login_user
      it "shouldn't increment book count by one" do
        before = Book.all.length
        post :create, params: {:book => attributes_for(:book)}
        after = Book.all.length
        expect(before==after).to eq(true)
      end
    end

    context "as a not signed-in user with valid params" do
      it "shouldn't increment book count by one" do
        before = Book.all.length
        post :create, params: {:book => attributes_for(:book)}
        after = Book.all.length
        expect(before==after).to eq(true)
      end
    end
  end

  describe "GET #show" do
    context "as a basic user with a valid book id" do
      login_user
      it "should render show page correctly" do
        book = create(:book)
        get :show, params:{:id => book.id}
        expect(response.status).to eq(200)
      end
    end

    context "as an admin with a valid book id" do
      login_admin
      it "should render show page correctly" do
        book = create(:book)
        get :show, params:{:id => book.id}
        expect(response.status).to eq(200)
      end
    end

    context "as an operator with a valid book id" do
      login_operator
      it "should render show page correctly" do
        book = create(:book)
        get :show, params:{:id => book.id}
        expect(response.status).to eq(200)
      end
    end

    context "as a not signed-in user with a valid book id" do
      it "should redirect to the sign in page" do
        book = create(:book)
        get :show, params:{:id => book.id}
        assert_redirected_to user_session_url
      end
    end

    context "as a signed-in user with an invalid book id" do
      login_user
      it "should raise a RecordNotFound error" do
        expect{get :show, params:{:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "DELETE #destroy" do
    context "as an operator with a valid book id" do
      login_operator
      it "book count should not change" do
        book = create(:book)
        before = Book.all.length
        delete :destroy, params: {:id => book.id}
        after = Book.all.length
        expect(before==after).to eq(true)
      end
    end

    context "as an admin with a valid book id" do
      login_admin
      it "should decrement book count by one" do
        book = create(:book)
        before = Book.all.length
        delete :destroy, params: {:id => book.id}
        after = Book.all.length
        expect(before>after).to eq(true)
      end
    end

    context "as a basic user with a valid book id" do
      login_user
      it "book count should not change" do
        book = create(:book)
        before = Book.all.length
        delete :destroy, params: {:id => book.id}
        after = Book.all.length
        expect(before==after).to eq(true)
      end
    end

    context "as a not signed-in user with a valid book id" do
      it "book count should not change" do
        book = create(:book)
        before = Book.all.length
        delete :destroy, params: {:id => book.id}
        after = Book.all.length
        expect(before==after).to eq(true)
      end
    end

    context "as an admin with an invalid book id" do
      login_admin
      it "should raise a RecordNotFound error" do
        expect{delete :destroy, params:{:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end


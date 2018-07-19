require 'rails_helper'

RSpec.describe BooksController, type: :controller do

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

  describe "PUT #enable" do
    context "as an operator with a valid and disabled book id" do
      login_operator
      it "book property isDisabled should not change" do
        book = create(:book)
        book.isDisabled=true;
        book.save
        put :enable, params: {:id => book.id}
        expect(book.isDisabled).to_not eq(book.reload.isDisabled)
      end
      it "book property isDisabled should change from true to false" do
        book = create(:book)
        book.isDisabled=true;
        book.save
        put :enable, params: {:id => book.id}
        expect((book.isDisabled==true and book.reload.isDisabled==false)).to eq(true)
      end
    end

    context "as an admin with a valid and disabled book id" do
      login_admin
      it "book property isDisabled shouldn't change" do
        book = create(:book)
        book.isDisabled=true;
        book.save
        put :enable, params: {:id => book.id}
        expect(book.isDisabled).to_not eq(book.reload.isDisabled)
      end
      it "book property isDisabled should change from true to false" do
        book = create(:book)
        book.isDisabled=true;
        book.save
        put :enable, params: {:id => book.id}
        expect((book.isDisabled==true and book.reload.isDisabled==false)).to eq(true)
      end
    end

    context "as a basic user with a valid and disabled book id" do
      login_user
      it "book property isDisabled shouldn't change" do
        book = create(:book)
        book.isDisabled=true
        book.save
        put :enable, params: {:id => book.id}
        expect(!book.isDisabled).to eq(!book.reload.isDisabled)
      end
    end

    context "as a basic user with a valid and disabled book id" do
      it "book properties shouldn't change" do
        book = create(:book)
        book.isDisabled=true
        book.save
        attr = get_attributes book
        put :enable, params: {:id => book.id}
        expect(attr).to eq(get_attributes book.reload)
      end
    end

    context "as an admin with a valid and enabled book id" do
      login_admin
      it "book properties shouldn't change" do
        book = create(:book)
        attr = get_attributes book
        put :enable, params: {:id => book.id}
        expect(attr).to eq(get_attributes book.reload)
      end
    end

    context "as an admin with an invalid book id" do
      login_admin
      it "should raise a RecordNotFound error" do
        expect{put :disable, params:{:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "PUT #disable" do
    context "as an operator with a valid and enabled book id" do
      login_operator
      it "book property isDisabled should not change" do
        book = create(:book)
        put :disable, params: {:id => book.id}
        expect(book.isDisabled).to_not eq(book.reload.isDisabled)
      end
      it "book property isDisabled should change from false to true" do
        book = create(:book)
        put :disable, params: {:id => book.id}
        expect((book.isDisabled==false and book.reload.isDisabled==true)).to eq(true)
      end
    end

    context "as an admin with a valid and enabled book id" do
      login_admin
      it "book property isDisabled should change" do
        book = create(:book)
        put :disable, params: {:id => book.id}
        expect(book.isDisabled).to_not eq(book.reload.isDisabled)
      end
      it "book property isDisabled should change from false to true" do
        book = create(:book)
        put :disable, params: {:id => book.id}
        expect((book.isDisabled==false and book.reload.isDisabled==true)).to eq(true)
      end
    end

    context "as a basic user with a valid and enabled book id" do
      login_user
      it "book property isDisabled shouldn't change" do
        book = create(:book)
        put :disable, params: {:id => book.id}
        expect(!book.isDisabled).to eq(!book.reload.isDisabled)
      end
    end

    context "as a basic user with a valid and enabled book id" do
      it "book properties shouldn't change" do
        book = create(:book)
        attr = get_attributes book
        put :disable, params: {:id => book.id}
        expect(attr).to eq(get_attributes book.reload)
      end
    end

    context "as an admin with a valid and disabled book id" do
      login_admin
      it "book properties shouldn't change" do
        book = create(:book)
        book.isDisabled = true
        book.save
        attr = get_attributes book
        put :disable, params: {:id => book.id}
        expect(attr).to eq(get_attributes book.reload)
      end
    end

    context "as an admin with an invalid book id" do
      login_admin
      it "should raise a RecordNotFound error" do
        expect{put :disable, params:{:id => -1}}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end


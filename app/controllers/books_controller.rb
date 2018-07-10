class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  skip_authorize_resource :only => [:search_form,:results_search]
  load_and_authorize_resource
  # GET /books
  # GET /books.json
  def index
    @books = Book.all.paginate(page: params[:page], per_page: 15)
  end

  def search_form
  end

  def results_search
    title_valid = ApplicationHelper.isValidString(params[:title])
    author_valid = ApplicationHelper.isValidString(params[:author])
    year_valid = true
    if !ApplicationHelper.isValidString(params[:released_at]) or params[:released_at].to_i <0
      year_valid = false
    end

    if ApplicationHelper.isValidString(params[:isbn]) and (params[:isbn].to_s.length==13 or params[:isbn].to_s.length==10)
      return @books = Array(Book.all.select{|i| i.isbn == params[:isbn].to_s.strip}).paginate(page: params[:page], per_page: 15)
    elsif title_valid or author_valid or year_valid
        @search = Book.ransack(title_cont: params[:title], author_cont: params[:author], released_at_eq: params[:released_at])
        return @books = Array(@search.result).paginate(page: params[:page], per_page: 15)
    else
      redirect_back fallback_location: root_path, alert: 'Invalid search request' + title_valid.to_s + author_valid.to_s + year_valid.to_s and return
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :publisher, :overview, :isbn, :created_at, :released_at, :coverlink)
    end
end

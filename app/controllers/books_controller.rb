class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = User.find(current_user.id)
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
    if current_user != @book.user
      @books = Book.all
      redirect_to books_path
    end
  end

  def update
     @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id)
       flash[:success] = "You have updated book successfully."
    else
      @user = User.find(current_user.id)
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end

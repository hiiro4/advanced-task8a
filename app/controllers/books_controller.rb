class BooksController < ApplicationController

  def show
    @book=Book.find(params[:id])
    @user=User.find(@book.user_id)
    @books=Book.new
    @book_comment=BookComment.new

    @current_userEntry=Entry.where(user_id:current_user.id)
    @userEntry=Entry.where(user_id:@user.id)
    unless @user.id == current_user.id
      @current_userEntry.each do |cu|
        @userEntry.each do |c|
          if cu.room_id == c.room_id
            @haveRoom = true
            @roomId= cu.room_id
          end
        end
      end
      unless @haveRoom
        @room = Room.new
        @entry=Entry.new
      end
    end
  end


  def index
    @book = Book.new
    @books = Book.includes(:favorites).sort{|a,b| b.favorites.size<=>a.favorites.size}
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless  @book.user_id==current_user.id
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end

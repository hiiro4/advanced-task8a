class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
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
    @users = User.all
    @book = Book.new
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

#フォロー、フォロワー機能a

  def follows
  user = User.find(params[:id])
  @users = user.following_user
  end

  def followers
  user = User.find(params[:id])
  @users = user.follower_user
  end

#終了
#検索機能a




  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

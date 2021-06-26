class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    redirect_back(fallback_location: user_path(@user))
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: user_path(@user))
  end

  def following
    @user = User.find(params[:id])
    if @user
      @follow = @user.followed_users
      render actions: :show
      @following = @user.followees.all
    end
  end

  def show
      @user = User.find(params[:id])
      if @user
        @posts = @user.favorited_posts
        render actions: :show
        @favorites = @user.favorites.all
      else
          render file: 'public/404', status: 404, formats: [:html]
      end
    end

  def favorited?(post)
      favorites.find_by(post_id: post.id).present?
    end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User deleted.'
  end

end

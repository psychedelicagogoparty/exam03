class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  # ajax化のためにJavascriptを呼び出す
  respond_to :js


  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # jsを返す(create.js.erbを読みに行く)
    respond_with @user
  end

  # def destroy
  #   @user = User.find(params[:id]).followed
  #   current_user.unfollow!(@user)
  #   # jsを返す(destroy.js.erbを読みに行く)
  #   respond_with @user
  # end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end
  
end

class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.create(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Following friend."
    else
      flash[:alert] = "There was something wrong with the tracking request."
    end
    redirect_to my_friends_path
  end

  def destroy
  	@friendships = current_user.friendships.where(friend_id: params[:id]).first
  	@friendships.destroy
  	flash[:notice] = "Stopped following."
  	redirect_to my_friends_path
  end
end

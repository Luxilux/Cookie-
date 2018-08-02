class UserController < ApplicationController
  def user_id
  end
  def login_required
      redirect_to('/user') if current_user.blank?
    end


end

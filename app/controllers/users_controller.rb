class UsersController < ApplicationController
  before_action :authenticate_user!, :admin_only!, only: [:index, :show, :edit]
  before_filter :count_visits

  STANDARD_CURRICULUM_PROJECT_IDS = [11, 12, 14, 15]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create(user_params)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit, user: @user
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def destroy
    @user = User.find(params[:id])
    @user.update_attribute(:status, User.statuses[:archived])
  end

  def artroom
    redirect_to thanks_path unless @visits.to_i > 1
    redirect_to '/users/sign_in' unless current_user.present?
    @products = current_user.purchased_products
    if current_user.is_paid?
      @standard_curriculum = get_standard_curriculum
    end
  end

  private
  def count_visits
    value = (cookies[:visits] || '0').to_i
    cookies[:visits] = (value + 1).to_s
    @visits = cookies[:visits]
  end
  
  def user_params
    params.require(:user).permit(:role, :email, :password, :password_confirmation, :current_password)
  end

  def get_standard_curriculum
    STANDARD_CURRICULUM_PROJECT_IDS.map { |id| ProjectSet.find_by_id(id) }
  end
end

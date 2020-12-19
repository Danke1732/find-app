class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.valid?
      @profile.save
      redirect_to profile_path(@profile.user_id)
    else
      render action: :new
    end
  end

  def show
    @profile = @user.profile unless @profile.nil?
    @articles = @user.articles.order('updated_at DESC').page(params[:page]).per(8)
  end

  def edit
    @profile = Profile.find_by(user_id: params[:user_id])
    redirect_to root_path if current_user.id != @profile.user_id
  end

  def update
    @profile = Profile.find_by(user_id: params[:user_id])
    redirect_to root_path if current_user.id != @profile.user_id
    @profile.update(profile_params)
    if @profile.valid?
      @profile.save
      redirect_to user_profiles_path(@profile.user_id)
    else
      render action: :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:hobby, :favorite_word, :introduction).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end

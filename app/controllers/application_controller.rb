class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authorize_admin
    redirect_to root_path unless current_user.admin?
  end

  def current_subsidiary
    current_user.subsidiary if current_user.user?
  end

  def current_user
    # return if super.blank?
    UserPresenter.new(super || NilUser.new)
    # UserPresenter.new(super.decorate || NIlUser.new) passando o decorator para o presenter
  end

  def user_signed_in?
    current_user.persisted?
    # current_user.is_a? User
  end
end

class UserPresenter < Draper::Decorator
  delegate_all

  def admin_navbar
    return '' unless admin?
    helpers.render partial: 'shared/admin_navbar'
  end

  def user_navbar
    return '' unless user?
    helpers.render partial: 'shared/user_navbar'
  end

  # private

  # def method_missing(method, *args, &block)
  #   object.public_send(method, *args, &block)
  # end
end

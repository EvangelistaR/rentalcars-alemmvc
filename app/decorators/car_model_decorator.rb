class CarModelDecorator < Draper::Decorator
  # include Rails.application.routes.url_helpers
  # Problemas de view context conferir o Draper
  delegate_all

  def photo
    return super if super.attached?

    'https://via.placeholder.com/150x150'
  end

  def car_options
    # Pode-ser usar o object no lugar de super por conta do draper
    return [] if super.blank?

    super.split(',')
  end
end
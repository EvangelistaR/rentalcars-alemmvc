class CarModelDecorator < Draper::Decorator
  delegate_all

  def photo
    'https://via.placeholder.com/150x150'
  end
end
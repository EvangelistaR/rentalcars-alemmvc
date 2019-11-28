class RentalBuilder
  def initialize(params, subsidiary)
    @params = params
    @subsidiary = subsidiary
  end

  def build
    Rental.new(params) do |rental|
      rental.subsidiary = subsidiary
      rental.status = :scheduled
      rental.price_projection = rental.calculate_price_projection
    end
  end

  private
    attr_reader :params, :subsidiary
end
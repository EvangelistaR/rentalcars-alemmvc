class RentalConfirmer

  def initialize(rental car_id, addon_ids = [])
    @rental = rental
    @car_id =car_id
    @addon_ids = addon_ids
  end

  def confirm
    return false unless car

    create_car
    allocate_addons
    rental.update(price_projection: rental.calculate_final_price)
    true
  end

  private

    attr_reader :rental, :car_id, :addon_ids

    def allocate_addons
     return unless addons?
      addon_items = addons.map { |addon| addon.first_available_item }
      addon_items.each do |addon_item|
        rental.rental_items.create(
                                    rentable: addon_item,
                                    daily_rate: addon_item.addon.daily_rate
                                  )
      end
    end

    def car
      @car ||= Car.find_by(id: car_id)
    end

    def addons
      @addons ||= Addon.where(id: addon_ids)
    end

    def addon?
      @addons.present?
    end

    def create_car
      rental.rental_items.create(rentable: car, daily_rate: car.daily_rate)
    end
end
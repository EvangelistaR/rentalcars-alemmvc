require 'rails_helper'

describe CarModelDecorator do
  context '#photo' do
    it 'should render image if present' do
      car_model = build(:car_model)

      expect(car_model.decorate.photo).to eq('https://via.placeholder.com/150x150')
    end
  end
end
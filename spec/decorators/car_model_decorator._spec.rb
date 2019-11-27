require 'rails_helper'

describe CarModelDecorator do
  context '#photo' do
    it 'should render image if not present' do
      car_model = build(:car_model)

      expect(car_model.decorate.photo).to eq('https://via.placeholder.com/150x150')
    end

    it 'should render image if attached' do
      car_model = build(:car_model)
      car_model.photo.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', '150x150.png')),
        filename: '150x150.png'
      )

      expect(car_model.decorate.photo).to be_attached
    end
  end

  context '#car_options' do
    it 'should return an array of car options' do
      car_model = build(
                         :car_model,
                         car_options: 'Quatro portas,ar-condicionado'
                        ).decorate

      expect(car_model.car_options).to include('Quatro portas')
      expect(car_model.car_options).to include('ar-condicionado')
      expect(car_model.car_options.count).to eq 2
    end

    it 'should return empty array' do
      car_model = build(:car_model, car_options: nil).decorate

      expect(car_model.car_options).to be_empty
    end
  end
end
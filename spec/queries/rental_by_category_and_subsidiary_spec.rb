require 'rails_helper'

describe RentalByCategoryAndSubsidiary do
  context '.call' do
    it 'should filter by category' do
      subsidiary = create(:subsidiary, name: 'Paulista')

      other_subsidiary = create(:subsidiary, name: 'Vila Mariana')

      category_a = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
      third_party_insurance: 20)
      category_b = create(:category, name: 'B', daily_rate: 50, car_insurance: 50,
      third_party_insurance: 90)

      customer = create(:individual_client, name: 'Claudionor',
          cpf: '318.421.176-43', email: 'cro@email.com')

      create_list(:car, 10, category: category_a)
      create_list(:car, 10, category: category_b)

      
      create(:rental, category: category_b, subsidiary: subsidiary,
        start_date: '2019-02-08', end_date: '2019-02-10',
        client: customer, price_projection: 100, status: :scheduled
      )

      create(:rental, category: category_a, subsidiary: subsidiary,
        start_date: '2019-03-05', end_date: '2019-03-10',
        client: customer, price_projection: 100, status: :scheduled
      )
      create(:rental, category: category_b, subsidiary: subsidiary,
        start_date: '2019-03-08', end_date: '2019-03-10',
        client: customer, price_projection: 100, status: :scheduled
      )

      create(:rental, category: category_a, subsidiary: other_subsidiary,
        start_date: '2019-01-08', end_date: '2019-01-10',
        client: customer, price_projection: 100, status: :scheduled
      )

      create(:rental, category: category_a, subsidiary: other_subsidiary,
        start_date: '2019-03-05', end_date: '2019-03-10',
        client: customer, price_projection: 100, status: :scheduled
      )

      start = '2019-01-01'
      finish= '2019-12-01'

      result = described_class.new(start, finish).call

      expect(result.first['subsidiary']).to eq 'Paulista'
      expect(result.first['category']).to eq 'B'
      expect(result.first['total']).to eq 2
    end
  end
end
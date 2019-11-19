require 'rails_helper'

feature 'User schedules rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    car = create(:car, car_model: car_model)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    find(:css, '.start_date').set('3000-01-01')
    find(:css, '.end_date').set('3000-01-07')
    find(:css, '#inputGroupSelect01').set('Claudionor')
    find(:css, '#inputGroupSelect02').set('A')
    click_on 'Agendar'

    expect(page).to have_css('h1', text: 'Locação de: Claudionor')
    expect(page).to have_css('h3', text: 'Status: agendada')
    expect(page).to have_css('p', text: 'cro@email.com')
    expect(page).to have_css('p', text: '318.421.176-43')
    expect(page).to have_css('p', text: '01 de janeiro de 3000')
    expect(page).to have_css('p', text: '07 de janeiro de 3000')
    expect(page).to have_css('p', text: 'Almeida Motors')
    expect(page).to have_css('p', text: 'Categoria: A')
    expect(page).to have_css('p', text: 'R$ 300,00')
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    car = create(:car, car_model: car_model)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    find(:css, '.start_date').set('')
    find(:css, '.end_date').set('')
    find(:css, '#inputGroupSelect01').set('')
    find(:css, '#inputGroupSelect02').set('')
    click_on 'Agendar'

    expect(page).to have_content('Data de início deve ser definida')
    expect(page).to have_content('Data de término deve ser definida')
  end

  scenario 'and end date must be greater then start date' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    create(:individual_client, name: 'Claudionor',
                    cpf: '318.421.176-43', email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    car = create(:car, car_model: car_model)
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    find(:css, '.start_date').set('3000-01-07')
    find(:css, '.end_date').set('3000-01-01')
    find(:css, '#inputGroupSelect01').set('Claudionor')
    find(:css, '#inputGroupSelect02').set('A')
    click_on 'Agendar'

    expect(page).to have_content('Data de início não pode ser maior que data de término')
  end

  scenario 'and cars of the chosen category must be available' do
    subsidiary = create(:subsidiary, name: 'Almeida Motors')
    user = create(:user, subsidiary: subsidiary)
    category = create(:category, name: 'A', daily_rate: 10, car_insurance: 20,
                      third_party_insurance: 20)
    other_category = create(:category, name: 'B', daily_rate: 10,
                            car_insurance: 20,
                            third_party_insurance: 20)
    manufacture = create(:manufacture)
    fuel_type = create(:fuel_type)
    create(:individual_client, name: 'Claudionor', cpf: '318.421.176-43',
           email: 'cro@email.com')
    car_model = create(:car_model, name: 'Sedan', manufacture: manufacture,
                       fuel_type: fuel_type, category: category)
    car = create(:car, car_model: car_model, status: :unavailable)
    login_as user, scope: :user
    create(:rental, )

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    find(:css, '.start_date').set('3000-01-01')
    find(:css, '.end_date').set('3000-01-02')
    find(:css, '#inputGroupSelect01').set('Claudionor')
    find(:css, '#inputGroupSelect02').set('B')
    click_on 'Agendar'

    expect(page).to have_content('Não há carros disponíveis na categoria escolhida.')
  end
end

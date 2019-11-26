FactoryBot.define do
  factory :rental do
    start_date { "2019-11-13" }
    end_date { "2019-11-13" }
    client
    category
    subsidiary
    status { 0 }

    trait :without_callbacks do
      after(:build) do |rental|
        rental.class.skip_callback(:create, :generate_reservation_code)
      end

      after(:create) do |rental|
        rental.class.set_callback(:create, :generate_reservation_code)
      end
    end
  end
end

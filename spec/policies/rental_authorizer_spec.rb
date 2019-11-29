# require 'rails_helper'

# describe RentalAuthorizer do
#   context '#authorized?' do
#     it 'should be true if admin' do
#       user = create(:user, role: :admin)
#       rental = create(:rental)

#       expected(described_class.new(rental, user).to be_authorized)
#     end

#     it 'should be true if employee' do
#       user = create(:user, role: :employee)
#       rental = create(:rental)

#       expected(described_class.new(rental, user).to be_authorized)
#     end

#     it 'not authorize unless admin or employees' do
#       user = create(:user, role: :user)
#       rental = create(:rental)

#       expected(described_class.new(rental, user).to be_false)
#     end
#   end
# end
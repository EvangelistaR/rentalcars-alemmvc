require 'rails_helper'

describe RentalPresenter do
  describe '#status_badge' do
    it'should render green color when finalized' do
      rental = build(:rental, status: :finalized)

      result = RentalPresenter.new(rental).status_badge

      expect(result).to eq('<span class="badge badge-finalized">finalizada</span>')
    end

    it 'should render blue color when ongoing' do
      rental = build(:rental, status: :ongoing)

      result = RentalPresenter.new(rental).status_badge

      expect(result).to eq('<span class="badge badge-ongoing">em andamento</span>')
    end
  end
end
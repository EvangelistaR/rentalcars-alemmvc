require 'rails_helper'

describe NilUser do
  context '#email' do
    it { expect(subject.email).to eq '' } #subject ẽ uma sintaxe do rspec, cria uma
  end

  context '#admin' do
    it { expect(subject.admin?).to eq false }
  end

  context '#user' do
    it { expect(subject.user?).to eq false }
  end

  context '#persisted?' do
    it { expect(subject.persisted?).to eq false }
  end
end
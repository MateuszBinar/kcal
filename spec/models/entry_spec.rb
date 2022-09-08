require 'rails_helper'

RSpec.describe Entry, type: :model do
  context 'validations' do
    it { should validate_presence_of(:calories) }
    it { should validate_presence_of(:proteins) }
    it { should validate_presence_of(:carbohydrates) }
    it { should validate_presence_of(:fats) }
    it { should validate_presence_of(:meal_type) }
  end

  describe Entry do
    it { should belong_to(:user) }
    it { should have_one(:photo) }
    it { should accept_nested_attributes_for :photo }
  end

  context "#day" do
    let(:user){ create(:user) }
    let(:entry){ create(:entry, user: user, created_at: 'Wed, 07 Sep 2022 00:00:00 CEST +02:00') }

    it { expect(entry.day).to match('Sep 7, 2022') } 
  end
end

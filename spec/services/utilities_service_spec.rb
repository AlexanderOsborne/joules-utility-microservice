require './spec/spec_helper'


RSpec.describe UtilitiesService do

  describe 'when I want stuff from utilityapi' do
    it 'can hit the utilities list endpoint' do
      utilities = UtilitiesService.fetch_utilities

      expect(utilities).to be_an(Array)

      utilities.each do |utility|
        expect(utility.class).to eq(Utility)
      end
    end

    it 'can get all the bills' do
      params = {meter_uid: 711267}
      bills = UtilitiesService.check_status(params)

      expect(bills).to be_an(Array)
      
      bills.each do |bill|
        expect(bill.class).to eq(Bill)
      end
    end
  end
end
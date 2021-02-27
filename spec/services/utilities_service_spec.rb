require './spec/spec_helper'


RSpec.describe UtilitiesService do

  describe 'when I want stuff from utilityapi' do
    xit 'can hit the utilities list endpoint' do
      utilities = UtilitiesService.fetch_utilities

      expect(utilities).to be_an(Array)

      utilities.each do |utility|
        expect(utility.class).to eq(Utility)
      end
    end

    xit 'can get all the bills' do
      params = {meter_uid: 711267}
      bills = UtilitiesService.check_status(params)

      expect(bills).to be_an(Array)
      
      bills.each do |bill|
        expect(bill.class).to eq(Bill)
      end
    end

    xit 'can create new user profile' do
      data = {customer_email: "jlfoxcollis@gmail.com", utility: "ACE"}
      user= UtilitiesService.get_new_user(data)
    end

    xit 'can create form' do
      form = UtilitiesService.create_form("auron1731@yahoo.com", "ACE")
      binding.pry
      expect(form).to have_key(:url)
    end

    it 'can get meters' do
      meters = UtilitiesService.get_meters("186139")
    end
  end
end
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

    
    it 'can create form' do
      data = {customer_email: "auron1731@yahoo.com", utility: "ACE"}
      form = UtilitiesService.create_form(data)
      expect(form).to have_key(:url)
    end
    
    it 'can get meters' do
      meters = UtilitiesService.get_meters("186139")
      
      expect(meters).to be_an(Array)
      expect(meters).to eq(['711267'])
    end

    it 'can get meters for existing user' do
      meters = UtilitiesService.activate_existing_user(["711267"])

      expect(meters[:meters]).to eq([])
      expect(meters[:success]).to eq(true)
    end

    it 'can get all the bills' do
      params = {meter_uid: '711267'}
      bills = BillsFacade.check_the_bills(params)
      expect(bills).to eq("Bills aren't ready yet.")
    end
  end
end
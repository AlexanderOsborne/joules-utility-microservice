require './spec/spec_helper'

RSpec.describe UtilitiesController do
  def app
    UtilitiesController
  end
  describe 'it can get all utilities' do

    it "can get a json response" do
      get "/utilities"

      # expect(current_path).to eq("/utilities")
      expect(last_response).to be_successful

      utilities = JSON.parse(last_response.body, symbolize_names: true)

      expect(utilities).to have_key(:data)
      expect(utilities[:data]).to be_an(Array)
      utilities[:data].each do |utility|
        expect(utility).to have_key(:id)
        expect(utility).to have_key(:utility_name)
      end
    end
  end

  describe 'it can get all bills' do
    it 'can get a json response' do
      get "/bills?meter_uid=711267"
      expect(last_response).to be_successful

      bills = JSON.parse(last_response.body, symbolize_names: true)

      expect(bills).to have_key(:data)
      expect(bills[:data]).to be_an(Array)
      bills[:data].each do |bill|
        expect(bill).to have_key(:start_date)
        expect(bill).to have_key(:end_date)
        expect(bill).to have_key(:kwh)
        expect(bill).to have_key(:meter_uid)
        expect(bill).to have_key(:user_uid)
      end
    end

    it 'can sad path for bill' do
      get "/bills"
      expect(last_response).to_not be_successful

      parsed = JSON.parse(last_response.body, symbolize_names: true)

      expect(parsed).to have_key(:data)
      expect(parsed[:data]).to eq("Must send meter_uid")
    end
  end

  describe 'it can start a new user' do
    it 'will create a new user' do
      get "/new_user?email=auron1731@yahoo.com&utility=ACE"

      expect(last_response).to be_successful
      parsed = JSON.parse(last_response.body, symbolize_names: true)

      expect(parsed[:data]).to have_key(:url)
    end

    it 'can sad path if missing params' do
      get "/new_user?utility=ACE"

      expect(last_response).to_not be_successful
      parsed = JSON.parse(last_response.body, symbolize_names: true)

      expect(parsed[:data]).to eq("Must send customer email and utility ID")
    end
  end

  describe 'it can get meters' do
    it 'will get meters' do
      get "/get_meters?referral=186139"

      expect(last_response).to be_successful
      parsed = JSON.parse(last_response.body, symbolize_names: true)

      expect(parsed[:data]).to be_an(Array)
    end

    it 'can sad path if missing referral' do
      get "/get_meters"

      expect(last_response).to_not be_successful
      parsed = JSON.parse(last_response.body, symbolize_names: true)

      expect(parsed[:data]).to eq("Must send customer email and utility ID")
    end
  end

end
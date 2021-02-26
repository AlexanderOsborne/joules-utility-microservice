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
end
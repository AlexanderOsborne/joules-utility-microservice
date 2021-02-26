require './spec/spec_helper'

RSpec.describe "when a user visits /utilities" do
  it "can get a json response" do
    visit "/utilities"

    expect(current_path).to eq("/utilities")
  end
end
require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        user: nil,
        ip_address: "Ip Address",
        address_1: "Address 1",
        address_2: "Address 2",
        city: "City",
        state: "State",
        zip: "Zip",
        country: "Country",
        lattitude: "Lattitude",
        longitude: "Longitude"
      ),
      Location.create!(
        user: nil,
        ip_address: "Ip Address",
        address_1: "Address 1",
        address_2: "Address 2",
        city: "City",
        state: "State",
        zip: "Zip",
        country: "Country",
        lattitude: "Lattitude",
        longitude: "Longitude"
      )
    ])
  end

  it "renders a list of locations" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Ip Address".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address 1".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address 2".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("City".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("State".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Zip".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Country".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Lattitude".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Longitude".to_s), count: 2
  end
end

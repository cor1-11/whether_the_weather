require 'rails_helper'

RSpec.describe "locations/show", type: :view do
  before(:each) do
    assign(:location, Location.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Ip Address/)
    expect(rendered).to match(/Address 1/)
    expect(rendered).to match(/Address 2/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Lattitude/)
    expect(rendered).to match(/Longitude/)
  end
end

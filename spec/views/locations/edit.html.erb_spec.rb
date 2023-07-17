require 'rails_helper'

RSpec.describe "locations/edit", type: :view do
  let(:location) {
    Location.create!(
      user: nil,
      ip_address: "MyString",
      address_1: "MyString",
      address_2: "MyString",
      city: "MyString",
      state: "MyString",
      zip: "MyString",
      country: "MyString",
      lattitude: "MyString",
      longitude: "MyString"
    )
  }

  before(:each) do
    assign(:location, location)
  end

  it "renders the edit location form" do
    render

    assert_select "form[action=?][method=?]", location_path(location), "post" do

      assert_select "input[name=?]", "location[user_id]"

      assert_select "input[name=?]", "location[ip_address]"

      assert_select "input[name=?]", "location[address_1]"

      assert_select "input[name=?]", "location[address_2]"

      assert_select "input[name=?]", "location[city]"

      assert_select "input[name=?]", "location[state]"

      assert_select "input[name=?]", "location[zip]"

      assert_select "input[name=?]", "location[country]"

      assert_select "input[name=?]", "location[lattitude]"

      assert_select "input[name=?]", "location[longitude]"
    end
  end
end

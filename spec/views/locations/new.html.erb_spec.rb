require 'rails_helper'

RSpec.describe "locations/new", type: :view do
  before(:each) do
    assign(:location, Location.new(
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
    ))
  end

  it "renders new location form" do
    render

    assert_select "form[action=?][method=?]", locations_path, "post" do

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

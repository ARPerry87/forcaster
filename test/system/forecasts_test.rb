require "application_system_test_case"

class ForecastsTest < ApplicationSystemTestCase
  test "show" do
    address = Faker::Address.full_address

    visit url_for \
      controller: "forecasts",
      action: "show",
      address: {
        address: address
      }
      assert_selector "h1", text: "Forecast"
    end
end

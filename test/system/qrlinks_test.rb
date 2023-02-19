require "application_system_test_case"

class QrlinksTest < ApplicationSystemTestCase
  setup do
    @qrlink = qrlinks(:one)
  end

  test "visiting the index" do
    visit qrlinks_url
    assert_selector "h1", text: "Qrlinks"
  end

  test "should create qrlink" do
    visit qrlinks_url
    click_on "New qrlink"

    fill_in "Url", with: @qrlink.url
    click_on "Create Qrlink"

    assert_text "Qrlink was successfully created"
    click_on "Back"
  end

  test "should update Qrlink" do
    visit qrlink_url(@qrlink)
    click_on "Edit this qrlink", match: :first

    fill_in "Url", with: @qrlink.url
    click_on "Update Qrlink"

    assert_text "Qrlink was successfully updated"
    click_on "Back"
  end

  test "should destroy Qrlink" do
    visit qrlink_url(@qrlink)
    click_on "Destroy this qrlink", match: :first

    assert_text "Qrlink was successfully destroyed"
  end
end

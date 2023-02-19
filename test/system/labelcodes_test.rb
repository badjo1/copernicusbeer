require "application_system_test_case"

class LabelcodesTest < ApplicationSystemTestCase
  setup do
    @labelcode = labelcodes(:one)
  end

  test "visiting the index" do
    visit labelcodes_url
    assert_selector "h1", text: "Labelcodes"
  end

  test "should create labelcode" do
    visit labelcodes_url
    click_on "New labelcode"

    fill_in "Baseurl", with: @labelcode.baseurl
    fill_in "Code", with: @labelcode.code
    click_on "Create Labelcode"

    assert_text "Labelcode was successfully created"
    click_on "Back"
  end

  test "should update Labelcode" do
    visit labelcode_url(@labelcode)
    click_on "Edit this labelcode", match: :first

    fill_in "Baseurl", with: @labelcode.baseurl
    fill_in "Code", with: @labelcode.code
    click_on "Update Labelcode"

    assert_text "Labelcode was successfully updated"
    click_on "Back"
  end

  test "should destroy Labelcode" do
    visit labelcode_url(@labelcode)
    click_on "Destroy this labelcode", match: :first

    assert_text "Labelcode was successfully destroyed"
  end
end

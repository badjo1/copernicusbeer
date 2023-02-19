require "application_system_test_case"

class QrtagsTest < ApplicationSystemTestCase
  setup do
    @qrtag = qrtags(:one)
  end

  test "visiting the index" do
    visit qrtags_url
    assert_selector "h1", text: "Qrtags"
  end

  test "should create qrtag" do
    visit qrtags_url
    click_on "New qrtag"

    fill_in "Code", with: @qrtag.code
    click_on "Create Qrtag"

    assert_text "Qrtag was successfully created"
    click_on "Back"
  end

  test "should update Qrtag" do
    visit qrtag_url(@qrtag)
    click_on "Edit this qrtag", match: :first

    fill_in "Code", with: @qrtag.code
    click_on "Update Qrtag"

    assert_text "Qrtag was successfully updated"
    click_on "Back"
  end

  test "should destroy Qrtag" do
    visit qrtag_url(@qrtag)
    click_on "Destroy this qrtag", match: :first

    assert_text "Qrtag was successfully destroyed"
  end
end

require "test_helper"

class SitesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @qrtag = qrtags(:one)
  end

  test "redirect qrtag" do
    get redirect_url qr: 'q1', label: @qrtag.label.code, tag: @qrtag.code
    assert_redirected_to @qrtag.qrlink.url
  end

  test "redirect with claim label" do
    url_to = "https://redirect.to/"
    @qrtag.qrlink.update!(url: url_to)   
    @qrtag.update!(qrlink_id: nil)
    get redirect_url qr: 'q1', label: @qrtag.label.code, tag: @qrtag.code
    assert_redirected_to url_to 
  end

  # test "should claim latest label and redirect to qrlink" do
  #   url_to = "https://latest.to/"
  #   qrlink = Qrlink.create!(label_id: @qrtag.label_id, qrcode_id: @qrtag.qrcode_id, url: url_to)
  #   @qrtag.update!(qrlink_id: nil)
  #   get redirect_url qr: 'q1', label: @qrtag.label.code, tag: @qrtag.code
  #   assert_redirected_to url_to 
  # end

  test "redirect with claim default label" do
    qrlink = @qrtag.qrlink
    @qrtag.update!(qrlink_id: nil)   
    qrlink.destroy
    get redirect_url qr: 'q1', label: @qrtag.label.code, tag: @qrtag.code
    assert_redirected_to @qrtag.qrcode.baseurl 
  end

  test "redirect with invalid qrcode" do
    get redirect_url qr: 'q0', label: @qrtag.label.code, tag: @qrtag.code
    assert_redirected_to root_url
  end

  test "redirect with invalid label" do
    get redirect_url qr: "q#{@qrtag.qrcode.to_char_code}", 
      label: 'xxx', tag: @qrtag.code
    assert_redirected_to @qrtag.qrcode
  end

  test "redirect with invalid tag" do
    get redirect_url qr: "q#{@qrtag.qrcode.to_char_code}", 
      label: @qrtag.label.code, tag: 'xxx'
    assert_redirected_to @qrtag.qrcode
  end


  test "hofprint hack" do
    tag = @qrtag.code + '1'
    get redirect_url qr: 'q1', label: @qrtag.label.code, tag: tag
    assert_redirected_to @qrtag.qrlink.url
  end

end

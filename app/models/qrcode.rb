class Qrcode < ApplicationRecord
  belongs_to :batch

  def generate_token
    ticket_code = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Qrcode.exists?(code: random_token)
    end
  end

end

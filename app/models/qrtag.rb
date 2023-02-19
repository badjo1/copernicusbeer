class Qrtag < ApplicationRecord
	belongs_to :label
	belongs_to :qrcode
	belongs_to :qrlink, optional: true

	
	def generate_token
	    self.code = loop do
	      # contain A-Z, a-z, 0-9, “-” and “_”. “=”	
	      random_token = SecureRandom.urlsafe_base64(11, true).first(11)
	      break random_token unless Qrtag.exists?(label_id: self.label_id, code: random_token)
	    end
  	end

  	def tagurl
  		return "http://cpbr.xyz/q#{qrcode.to_char_code}/#{label.code}/#{code}"
  	end

	def self.to_csv
	attributes = %w{tagurl}
	generate_csv(attributes)
	end

end

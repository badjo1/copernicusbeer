class Qrtag < ApplicationRecord
	belongs_to :label
	belongs_to :qrcode
	belongs_to :qrlink, optional: true
	
	scope :with_qrcode, -> { joins(:qrcode).includes(:qrcode).order(:labelnumber, :referencenumber) }

	
	def generate_token
	    self.code = loop do
	      random_token = Qrtag.eleven_token
	      break random_token unless Qrtag.exists?(label_id: self.label_id, code: random_token)
	    end
  	end

	# Returns a random token, contain A-Z, a-z, 0-9, “-” and “_”. “=”	
	def Qrtag.eleven_token
		SecureRandom.urlsafe_base64(11, true).first(11)
	end

  	def tagurl
  		return "http://cpbr.xyz/q#{qrcode.to_char_code}/#{label.code}/#{code}"
  	end

  	def to_url
  		qrlink ? qrlink.url : qrcode.baseurl
  	end


	def referencenumber
  		qrcode.referencenumber
  	end

	def self.to_csv
	attributes = %w{tagurl labelnumber referencenumber}
	generate_csv(attributes)
	end

end

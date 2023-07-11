class Qrcode < ApplicationRecord
	validates :referencenumber	, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 24,  only_integer: true }
	validates :baseurl 		, presence: true
  	validates :baseurl	    	, url: {allow_blank: true}

	scope :order_by_reference, -> { order('qrcodes.referencenumber ASC') }

	def code
		"#QR#{referencenumber.to_s.rjust(2, '0')}"
	end

	def to_char_code
      referencenumber.to_i.to_s(25)
   	end

	def self.to_reference (c)
      c.to_i(25)
   	end


end

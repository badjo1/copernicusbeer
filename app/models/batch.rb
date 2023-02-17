class Batch < ApplicationRecord
	validates_presence_of :serialnumber, :description
	has_many :qr_codes
end

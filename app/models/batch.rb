class Batch < ApplicationRecord
	validates_presence_of :serialnumber, :description
	has_many :qrcodes, dependent: :destroy

	def generateQR
	end

end

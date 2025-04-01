class Batch < ApplicationRecord
	has_many :labels, dependent: :destroy
	validates_presence_of :serialnumber, :description
	validates :serialnumber	, numericality: { only_integer: true }, allow_blank: true

	def name
		"Batch #{serialnumber}"
	end

end

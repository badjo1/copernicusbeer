class Batch < ApplicationRecord
	validates_presence_of :serialnumber, :description
	has_many :labels, dependent: :destroy

end

class Label < ApplicationRecord
	belongs_to :batch
	has_many :qrtags, dependent: :destroy
	has_many :qrlinks, dependent: :destroy

	validates :code        		, presence: true
	validates :code        		, length: {minimum: 1, maximum: 3}, allow_blank: true
	validates :number_of_labels	, numericality: { greater_than_or_equal_to: 1,  only_integer: true }

end


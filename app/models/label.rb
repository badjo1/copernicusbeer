class Label < ApplicationRecord
	belongs_to :batch
	has_many :qrtags, dependent: :destroy
	has_many :qrlinks

	validates :code        		, presence: true
	validates :code        		, length: {minimum: 1, maximum: 3}, allow_blank: true
	validates :number_of_labels	, numericality: { greater_than_or_equal_to: 1,  only_integer: true }

	def search
		self.qrtags.joins(:qrcode).includes(:qrcode).order(:labelnumber, :referencenumber)
	end

	def current_qrlinks
		self.qrlinks.joins(:qrcode).includes(:qrcode).order(:referencenumber).where("
	        qrlinks.created_at = (SELECT MAX(created_at)
	          FROM qrlinks ql
	          GROUP BY qrcode_id
	          HAVING ql.qrcode_id = qrlinks.qrcode_id
	        )
	      ")
	end

end


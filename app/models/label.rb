class Label < ApplicationRecord
	belongs_to :batch
	has_many :qrtags, dependent: :destroy
	has_many :qrlinks, dependent: :destroy

	validates :code        		, presence: true
	validates :code        		, length: {minimum: 1, maximum: 3}, allow_blank: true
	validates :number_of_labels	, numericality: { greater_than_or_equal_to: 1,  only_integer: true }

	def find_tag (code)
		self.qrtags.with_qrcode.find_by(code: code)
	end

	def name
		"Label #{code}"
	end

	def claim_label (labelnumber)
      tags_on_label = self.qrtags.where(labelnumber: labelnumber)
      latest_links =  self.qrlinks.latest_qrlinks  
      tags_on_label.each do |tag|   
        link=latest_links.find_by(qrcode_id: tag.qrcode_id)
        tag.update(qrlink_id: link.id) if link
        # ERROR: duplicate key value violates unique constraint "qrtags_pkey
        # tag.update(claimed_on: Time.current) if tag.id = @qrtag.id
      end
    end

end


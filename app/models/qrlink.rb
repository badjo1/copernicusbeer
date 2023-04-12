class Qrlink < ApplicationRecord
	belongs_to :label
	belongs_to :qrcode
	scope :latest_qrlinks, -> { where(created_at: select('MAX(created_at)').group(:qrcode_id)) }
	scope :with_qrcode, -> { joins(:qrcode).includes(:qrcode).order('qrcodes.referencenumber ASC') }

end

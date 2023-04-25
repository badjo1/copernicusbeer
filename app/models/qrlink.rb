class Qrlink < ApplicationRecord
	belongs_to :label
	belongs_to :qrcode
	scope :latest_qrlinks, -> { where(created_at: select('MAX(created_at)').and(Qrlink.where(valid_until: nil).or(Qrlink.where("valid_until > ?", Time.current))).group(:qrcode_id)) }
	scope :with_qrcode, -> { joins(:qrcode).includes(:qrcode).order('qrcodes.referencenumber ASC') }

end

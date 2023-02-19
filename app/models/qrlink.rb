class Qrlink < ApplicationRecord
	belongs_to :label
	belongs_to :qrcode
end

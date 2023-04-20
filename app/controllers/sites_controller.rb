class SitesController < ApplicationController

	def claimed
		@claimed  = Qrtag.where.not(claimed_on: nil).order(claimed_on: :desc)
	end

end

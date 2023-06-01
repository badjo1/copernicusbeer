class SitesController < ApplicationController

	def claimed
		@claimed  = Qrtag.where.not(claimed_on: nil).order(claimed_on: :desc)
	end

	def add_to_metamask
		to_url = "https://vittominacori.github.io/watch-token/page/?hash=0x7b2261646472657373223a22307841383542344432463544323731656642326431373736373434633262633264303930333343613933222c226c6f676f223a2268747470733a2f2f7777772e636f7065726e69637573626565722e78797a2f77702d636f6e74656e742f75706c6f6164732f323032332f30362f68757a7a61682e706e67227d&network=polygon_mainnet"
		redirect_to to_url, allow_other_host: true 
	end

end

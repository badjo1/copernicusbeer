class UsersController < ProtectedController
	
	def show
		@user = User.find(params[:id])
	end

	private

		def web3_client
			@web3_client ||= Eth::Client::create("https://mainnet.infura.io/v3/81c8126663b14ed899cb3290916915b1")
		end

		def ethereum
			deposit_contract = Eth::Address.new "0x756AA826359EF6a23a3c726f6ead959D10fF17EB"
			@balance = web3_client.get_balance deposit_contract
		end

		
end


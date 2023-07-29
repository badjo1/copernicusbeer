class UsersController < ProtectedController
	def show
		@user = User.find(params[:id])
	end
end


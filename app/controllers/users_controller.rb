class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def login
		
	end
end

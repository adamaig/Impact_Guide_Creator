class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@points = @user.points
		@impactGuides = ImpactGuide.where(creator_id: @user.id)
		responses = Response.where(user_id: @user.id)
		@responded = Hash.new
		seen = Array.new
		responses.each do |x|
			if check(seen,x)
				seen.push(x)
			end
		end
	end
	
	def index
	end

	def check(nums, look)
		nums.each do |q|
			if q == look
				return true
			end
		end	
		return false
	end

end

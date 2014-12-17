class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@points = @user.points
		@bio = @user.bio
		@impactGuides = ImpactGuide.where(creator_id: @user.id)
		responses = Response.where(user_id: @user.id)
		@responded = Hash.new
		@seen = Array.new
		responses.each do |x|
			if !check(@seen,x.impact_guide_id)
				@seen.push(x.impact_guide_id) if x != nil
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

	def edit
		if params[:id].to_i != current_user.id
			puts(params[:id])
			puts(current_user.id)
			puts(params[:id] != current_user.id)
			redirect_to root_path
		end
		@user = User.find(params[:id])
	end

	def update
		if params[:user][:avatar]
			current_user.update(avatar:  params[:user][:avatar], bio: params[:user][:bio])
		else
			current_user.update(bio: params[:user][:bio])
		end
		redirect_to current_user
	end

end

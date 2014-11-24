class ResponsesController < ApplicationController
	def create
		#byebug
		 params[:response].each do |k,v| 
		 	if v[:text] != "" 
		 		Response.create(v)
		 		p = v[:points].to_i + current_user.points
		 		current_user.update(points: p)
		 	end
		 end
	end
end

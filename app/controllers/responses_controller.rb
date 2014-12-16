class ResponsesController < ApplicationController
	def create
	
		 params[:response].each do |k,v| 
		 	if v[:text] != "" && !v[:id]
		 		r = Response.create(v)
		 		r.update(points: ImpactGuidePrompt.find(r.prompt_id).points, impact_guide_id: ImpactGuide.find(ImpactGuidePrompt.find(r.prompt_id).impact_guide_id).id)
		 		p = r.points + current_user.points
		 		current_user.update(points: p)

		 	elsif v[:text] != "" && v[:id]
		 		r = Response.find(v[:id])
		 		r.update(text: v[:text])
		 	end
		 end
		 redirect_to :back
	end

	
end

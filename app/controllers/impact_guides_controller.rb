class ImpactGuidesController < ApplicationController
  
  def new
    @impactGuide = ImpactGuide.new
    # 4.times { 
      @impactGuide.impact_guide_prompts.build( category: PromptCategory.where( moniker: "game_basics").first ) 
      # }
    # 4.times { @impactGuide.impact_guide_prompts.build( category: PromptCategory.where( moniker: "theme_insights").first ) }
    # 4.times { @impactGuide.impact_guide_prompts.build( category: PromptCategory.where( moniker: "world_connections").first ) }
  end
  def create
    @impactGuide = ImpactGuide.new(params[:impactGuide])
  redirect_to @impactGuide
  end
  def index
    
  end
  
  
 

end

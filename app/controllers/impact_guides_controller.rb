class ImpactGuidesController < ApplicationController
  helper_method :current_user

  def new
    @impactGuide = ImpactGuide.new
    # 4.times { 
     # @impactGuide.impact_guide_prompts.build( category: PromptCategory.where( moniker: "game_basics").first ) 
      # }
    # 4.times { @impactGuide.impact_guide_prompts.build( category: PromptCategory.where( moniker: "theme_insights").first ) }
    # 4.times { @impactGuide.impact_guide_prompts.build( category: PromptCategory.where( moniker: "world_connections").first ) }
  end
  

  def show
    @impactGuide = ImpactGuide.find(params[:id])


  end


  def create
  # byebug
   @impactGuide= ImpactGuide.new(age: params[:impact_guide][:age], time:  params[:impact_guide][:time], category_id: params[:impact_guide][:category_id])
    if @impactGuide.save
      @impactGuide.save!
      theme = Theme.new(params[:impact_guide][:theme].permit!,  ig_id: @impactGuide.id)
      if theme.save
        theme.save!
        game = Game.new(params[:impact_guide][:game].permit!, ig_id: @impactGuide.id)
        if game.save
          game.save!
          aboutDesc = IgAboutDescription.new(text: params[:impact_guide][:ig_about_description][:text], game_id: game.id)
          if aboutDesc.save
            aboutDesc.save!
           igt = IgThemeDescription.new(text: params[:impact_guide][:ig_theme_description][:text])
           if igt.save
            igt.save!
            @impactGuide.update(creator_id: @id, theme_id: theme.id, game_id: game.id)
            igt.update(themeId: theme.id)
           end
          else
            byebug
            game.delete
            theme.delete
            @impactGuide.delete
           return render 'new'
          end
        else
          byebug
          theme.delete
          @impactGuide.delete
         return render 'new'
        end
      else
       byebug
        @impactGuide.delete
       return render 'new'
      end
    else
     byebug
     return render 'new'
    end
   unless prompts 
      byebug
      theme.delete
      @impact_guide.delete
      game.delete
      render 'new'
   end

  savePrompts(@impactGuide.id)
  redirect_to @impactGuide
  end

   def prompts
      x = 0 
      params[:impact_guide][:game_basics_prompts].each do |k, v| 
        if v != "" 
          x+= 1 
        end
      end
      if x <3
        false
      end
       x = 0 
      params[:impact_guide][:theme_insight_prompts].permit!.each do |k, v| 
        if v != "" 
          x+= 1 
        end
      end
      if x <3
        false
      end
       x = 0 
      params[:impact_guide][:world_connections_prompts].each do |k, v| 
        if v != "" 
          x+= 1 
        end
      end
      if x <3
        false
      end
      true
    end

    def savePrompts(ig)
       x= 1
       params[:impact_guide][:game_basics_prompts].permit!.each do |k, v|
        if v != ""
          ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 1)
          x+=1
        end
      end
      x=0
      (params[:impact_guide][:theme_insight_prompts].permit!).each do |k, v|
        if v != ""
          ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 2)
          x+=1
        end
      end
      x=0
       params[:impact_guide][:world_connections_prompts].permit!.each do |k, v|
       if v != ""
          ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 3)
          x+=1
        end
      end
    end
  end
    
    



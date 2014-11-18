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
  
  def edit
    @impactGuide = ImpactGuide.find(params[:id])
  end


  def show
    @impactGuide = ImpactGuide.find(params[:id])
  end

  def index
    @all = ImpactGuide.all
  end

  def update
    #byebug

    @impactGuide= ImpactGuide.find(params[:id])

    @impactGuide.transaction do
      @impactGuide.update(age: params[:impact_guide][:age], 
                         time: params[:impact_guide][:time], 
                  category_id: params[:impact_guide][:category_id], 
           why_use_this_guide: params[:impact_guide][:why_use_this_guide])
      
      Theme.transaction(requires_new: true) do
        Theme.find(@impactGuide.theme_id).update(params[:impact_guide][:theme].permit!)
        
        Game.transaction(requires_new: true) do
          Game.find(@impactGuide.game_id).update(params[:impact_guide][:game].permit!)
        
          IgAboutDescription.transaction(requires_new: true) do
            IgAboutDescription.find_by(ig_id: @impactGuide.id).update(text: params[:impact_guide][:ig_about_description][:text])

            IgThemeDescription.transaction(requires_new: true) do
              IgThemeDescription.find_by(ig_id: @impactGuide.id).update(text: params[:impact_guide][:ig_theme_description][:text])

              ImpactGuidePrompt.transaction(requires_new: true) do
                if prompts
                  updatePrompts(@impactGuide.id)
                else
                  #flash(:danger) = "prompts were not updated"
                  raise ActiveRecord::Rollback
                end
              end
            end
          end
        end
      end
    end



  end

  def create
  #byebug
   @impactGuide= ImpactGuide.new(age: params[:impact_guide][:age], time:  params[:impact_guide][:time], category_id: params[:impact_guide][:category_id], why_use_this_guide:  params[:impact_guide][:why_use_this_guide] )
    if @impactGuide.save
      @impactGuide.save!
      theme = Theme.new(params[:impact_guide][:theme].permit!,  ig_id: @impactGuide.id)
      if theme.save
        theme.save!
        game = Game.new(params[:impact_guide][:game].permit!, ig_id: @impactGuide.id)
        if game.save
          game.save!
          aboutDesc = IgAboutDescription.new(text: params[:impact_guide][:ig_about_description][:text], game_id: game.id, ig_id: @impactGuide.id)
          if aboutDesc.save
            aboutDesc.save!
           igt = IgThemeDescription.new(text: params[:impact_guide][:ig_theme_description][:text])
           if igt.save
            igt.save!
            @impactGuide.update(creator_id: @id, theme_id: theme.id, game_id: game.id, creator_id: User.find(session[:user_id]).id)
            igt.update(themeId: theme.id, ig_id: @impactGuide.id)
           end
          else
            game.delete
            theme.delete
            @impactGuide.delete
           return render 'new'
          end
        else
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
     return render 'new'
    end
   unless prompts 
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
      x=1
      (params[:impact_guide][:theme_insight_prompts].permit!).each do |k, v|
        if v != ""
          ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 2)
          x+=1
        end
      end
      x=1
       params[:impact_guide][:world_connections_prompts].permit!.each do |k, v|
       if v != ""
          ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 3)
          x+=1
        end
      end
    end

      def updatePrompts(ig)
       x= 1
       params[:impact_guide][:game_basics_prompts].permit!.each do |k, v|
        if v != ""
          prompt = ImpactGuidePrompt.find_by(position: x, impact_guide_id: ig, category_id: 1)
          if prompt
            prompt.update(prompt: v, impact_guide_id: ig, position: x, category_id: 1)
          else
            ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 1)
          end
        x+=1
        end
      end
      x=1
      (params[:impact_guide][:theme_insight_prompts].permit!).each do |k, v|
        if v != ""
          prompt = ImpactGuidePrompt.find_by(position: x, impact_guide_id: ig, category_id: 2)
          if prompt
            prompt.update(prompt: v, impact_guide_id: ig, position: x, category_id: 2)
          else
            ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 2)
          end
          x+=1
        end
      end
      x=1
       params[:impact_guide][:world_connections_prompts].permit!.each do |k, v|
       if v != ""
         prompt = ImpactGuidePrompt.find_by(position: x, impact_guide_id: ig, category_id: 3)
          if prompt
            prompt.update(prompt: v, impact_guide_id: ig, position: x, category_id: 3)
          else
            ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 3)
          end
          x+=1
        end
      end
    end



  end
    
    



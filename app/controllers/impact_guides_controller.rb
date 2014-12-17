class ImpactGuidesController < ApplicationController
  helper_method :current_user

  def new
    @impactGuide = ImpactGuide.new
    #an array to be used for selecting the points to be used 
    @points = [["[+1]", 1], ["[+2]",2], ["[+3]", 3]]
    @theme = Theme.new
  end
  
  def edit
    @impactGuide = ImpactGuide.find(params[:id])
  end


  def show
   #defines all the variables to be used in the show page
    @impactGuide = ImpactGuide.find(params[:id])
    if current_user && current_user.id != @impactGuide.creator_id
      count = @impactGuide.views + 1
      @impactGuide.update(views: count)
    elsif !current_user
      count = @impactGuide.views + 1
      @impactGuide.update(views: count)
    end
    @category = ImpactArea.find(@impactGuide.category_id).name
    @themeName = Theme.find(@impactGuide.theme_id).name
    @gameTitle = Game.find(@impactGuide.game_id).title
    @age = @impactGuide.age
    @time = @impactGuide.time
    @quote =  Game.find(@impactGuide.game_id).quote
    @source = Game.find(@impactGuide.game_id).source
    @about = IgAboutDescription.find_by(ig_id: @impactGuide.id).text
    @themeAbout = IgThemeDescription.find_by(ig_id: @impactGuide.id).text
    @whyUse = @impactGuide.why_use_this_guide
    @basicPrompts = ImpactGuidePrompt.where(impact_guide_id: @impactGuide.id, category_id: 1).order(:position).map { |x| [x.prompt, x.points, x.id]}
    @themePrompts = ImpactGuidePrompt.where(impact_guide_id: @impactGuide.id, category_id: 2).order(:position).map { |x| [x.prompt, x.points, x.id]}
    @worldPrompts = ImpactGuidePrompt.where(impact_guide_id: @impactGuide.id, category_id: 3).order(:position).map { |x| [x.prompt, x.points, x.id]}
    @response = Response.new
    len = ImpactGuidePrompt.where(impact_guide_id: @impactGuide.id).length
    @responses = Array.new(len)
    for i in 0..len do 
      @responses[i] = "Response#{i}".to_sym
      #@responses[i]= @responses[i].to_sym
    end
    
    @counter = 0;
    #byebug
  end

  def index
   #creates a hash of all impact guides to list them
    @all = ImpactGuide.all
  end

  def update
    #byebug

    @impactGuide= ImpactGuide.find(params[:id])

    @impactGuide.transaction do
     if :cover
      @impactGuide.update(age: params[:impact_guide][:age], 
                         time: params[:impact_guide][:time], 
                  category_id: params[:impact_guide][:category_id], 
           why_use_this_guide: params[:impact_guide][:why_use_this_guide],
                        cover: params[:impact_guide][:cover])
     else
      @impactGuide.update(age: params[:impact_guide][:age], 
                         time: params[:impact_guide][:time], 
                  category_id: params[:impact_guide][:category_id], 
           why_use_this_guide: params[:impact_guide][:why_use_this_guide])
     end
      
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
    redirect_to @impactGuide
  end

  def create
  #byebug
  #defines an array to use if the code fails and renders new
  @points = [["[+1]", 1], ["[+2]",2], ["[+3]", 3]]
  #declares a new impact guide from the params hash
   @impactGuide= ImpactGuide.new(age: params[:impact_guide][:age], time:  params[:impact_guide][:time], category_id: params[:impact_guide][:category_id], why_use_this_guide:  params[:impact_guide][:why_use_this_guide], cover: params[:impact_guide][:cover], views: 0)
    #if the impactGuide is valid it saves it and declares a theme if not it renders new
    if @impactGuide.save
      @impactGuide.save!
      theme = Theme.new(params[:impact_guide][:theme].permit!,  ig_id: @impactGuide.id)
      #trys to save theme if it goes through it saves it and creates a game if not it deletes the impact guide and renders new
      if theme.save
        theme.save!
        game = Game.new(params[:impact_guide][:game].permit!, ig_id: @impactGuide.id)
        #if the game saves it creats an IgAbout Description if not it deletes the theme and the impact guide
        if game.save
          game.save!
          aboutDesc = IgAboutDescription.new(text: params[:impact_guide][:ig_about_description][:text], game_id: game.id, ig_id: @impactGuide.id)
          #tries to save the aboutDesc if it does it makes a themeDescription if not it deletes the about description theme and impact giude 
          if aboutDesc.save
            aboutDesc.save!
           igt = IgThemeDescription.new(text: params[:impact_guide][:ig_theme_description][:text])
           #tries to save igt if it fails it deletes game aboutDesc theme and impactguide and renders new
           if igt.save
            igt.save!
            @impactGuide.update(creator_id: @id, theme_id: theme.id, game_id: game.id, creator_id: User.find(session[:user_id]).id)
            igt.update(themeId: theme.id, ig_id: @impactGuide.id)
           else
            game.delete
            aboutDesc.delete
            theme.delete
            @impactGuide.delete
            return render 'new'
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
   #checks to see if the right amount of prompts have been filled out if they haven't it deletes theme impactguide
   #game aboutDesc igt then renders new
   unless prompts 
      theme.delete
      @impact_guide.delete
      game.delete
      aboutDesc.delete
      igt.delete
      render 'new'
   end
# if it passes it saves the prompts and sends you to the page showing you the impact guide
  savePrompts(@impactGuide.id)
  redirect_to @impactGuide
  end

   def prompts
      #sets external counter
      x = 0 
      #makes sure at least 3 of the promts where not left blank the game basics category if not returns false
      params[:impact_guide][:game_basics_prompts].each do |k, v| 
        if v != "" 
          x+= 1 
        end
      end
      if x <8
        false
      end
       #resets conter
       x = 0 
      #makes sure at least 3 of the promts where not left blank the theme insights category if not returns false
      params[:impact_guide][:theme_insight_prompts].permit!.each do |k, v| 
        if v != "" 
          x+= 1 
        end
      end
      if x <8
        false
      end
       #resets counter
       x = 0 
      #makes sure at least 3 of the promts where not left blank the theme insights category if not returns false
      params[:impact_guide][:world_connections_prompts].each do |k, v| 
        if v != "" 
          x+= 1 
        end
      end
      if x <8
        false
      end
      #returns true if it didn't hit false anywhere else in the code
      true
    end

    def savePrompts(ig)
      #saves position
       x= 1
       #external variable to save a prompt
       impact = ImpactGuidePrompt.new
       params[:impact_guide][:game_basics_prompts].permit!.each do |k, v|
        #makes sure the prompt is not empty or a number
        if v != "" && v != "1" && v != "2" && v != "3"
          #creates an impact guide with the given variables but not points yet
          impact = ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 1, points: 0)
          #increments positon
          x+=1
        #if v is 1 2 or 3 and impact does not have points defined it adds points to impact
        elsif (v == "1" || v == "2" || v == "3") && impact.points == 0
          impact.update(points: v)
        end
      end
      #resets external variables and repeats the process for category 2
      x=1
      impact = ImpactGuidePrompt.new
      (params[:impact_guide][:theme_insight_prompts].permit!).each do |k, v|
        if v != "" && v != "1" && v != "2" && v != "3"
         impact = ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 2, points: 0)
          x+=1
        elsif v == "1" || v == "2" || v == "3"  && impact.points == 0 
          impact.update(points: v)
        end
      end
      #resets external variables and repeats the process for category 3
      x=1
       impact = ImpactGuidePrompt.new
       params[:impact_guide][:world_connections_prompts].permit!.each do |k, v|
       if v != "" && v != "1" && v != "2" && v != "3"
         impact = ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 3, points:0)
          x+=1
        elsif v == "1" || v == "2" || v == "3"  && impact.points == 0
          impact.update(points: v)
        end
      end
    end

      def updatePrompts(ig)
       #holds the postition to be used
       x= 1
      #place holder impact guide prompt
      impact = ImpactGuidePrompt.new
       params[:impact_guide][:game_basics_prompts].permit!.each do |k, v| 
        #makes sure the value is not empty or a number
        if v != "" && v != "1" && v != "2" && v != "3"
          prompt = ImpactGuidePrompt.find_by(position: x, impact_guide_id: ig, category_id: 1)
          if prompt
            prompt.update(prompt: v, impact_guide_id: ig, position: x, category_id: 1)
            #stores the newly updated prompt to an external variable
            impact = prompt
             #increments the postion
            x+=1
          else
            #if it can not find an impact prompt for the selected guide that has the same category id and postion it creates one
            ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 1)
          end
        
        else
          #updates the points of an impact guide if it exists
          impact.update(points: v) if impact.prompt != ""
          #resets the impact variable
          impact = ImpactGuidePrompt.new
        end
      end
      #repeats the same process for the second category
      impact = ImpactGuidePrompt.new
      x=1
      (params[:impact_guide][:theme_insight_prompts].permit!).each do |k, v|
        if v != "" && v != "1" && v != "2" && v != "3"
          prompt = ImpactGuidePrompt.find_by(position: x, impact_guide_id: ig, category_id: 2)
          if prompt
            prompt.update(prompt: v, impact_guide_id: ig, position: x, category_id: 2)
            impact = prompt
            x+=1
          else
            ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 2)
          end
          
        else
          impact.update(points: v) if impact.prompt != ""
          impact = ImpactGuidePrompt.new
        end
      end
      #repeats the process again for the third category 
      impact = ImpactGuidePrompt.new
      x=1
       params[:impact_guide][:world_connections_prompts].permit!.each do |k, v|
       if v != "" && v != "1" && v != "2" && v != "3"
         prompt = ImpactGuidePrompt.find_by(position: x, impact_guide_id: ig, category_id: 3)
          if prompt
            prompt.update(prompt: v, impact_guide_id: ig, position: x, category_id: 3)
            impact = prompt
            x+=1
          else
            ImpactGuidePrompt.create(prompt: v, impact_guide_id: ig, position: x, category_id: 3)
          end
        else
          impact.update(points: v) if impact.prompt != ""
          impact = ImpactGuidePrompt.new
        end
      end
    end



  end
    
    



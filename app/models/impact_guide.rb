class ImpactGuide < ActiveRecord::Base
  has_many :impact_guide_prompts, class_name: "ImpactGuidePrompt"
  has_many :game_basics_prompts , -> { where( category: PromptCategory.where( moniker: "game_basics").first ).order("id ASC") }
  has_many :theme_insight_prompts , -> { where( category: PromptCategory.where( moniker: "theme_insights").first ).order("id ASC") }
  has_many :world_connections_prompts , -> { where( category: PromptCategory.where( moniker: "world_connections").first ).order("id ASC") }
  
=begin  def theme
    @theme = Theme.new
  end
 
  def game
    @game = Game.new
  end
 
  def ig_theme_description
    @ig_theme_description = IgThemeDescription.new
  end
 
  def ig_about_description
    @ig_about_description = IgAboutDescription.new
  end
=end
  
  
  
end

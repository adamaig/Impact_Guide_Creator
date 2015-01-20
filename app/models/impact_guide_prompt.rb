class ImpactGuidePrompt < ActiveRecord::Base
  has_one :category, class_name: "PromptCategory"

end

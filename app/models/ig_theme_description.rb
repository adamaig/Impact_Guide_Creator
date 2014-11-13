class IgThemeDescription < ActiveRecord::Base
	validates :text, presence: true, length: { minimum: 5, maximum: 1024 }
end

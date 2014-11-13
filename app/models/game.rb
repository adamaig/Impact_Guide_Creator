class Game < ActiveRecord::Base
	validates :title,  presence: true, length: { minimum: 5, maximum:255 }
	validates :quote, presence: true, length: { minimum: 5, maximum:255 }
	validates :source, presence: true, length: { minimum: 5, maximum:255 }
end

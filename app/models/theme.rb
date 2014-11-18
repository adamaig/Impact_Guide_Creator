class Theme < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 5, maximum:30}
end

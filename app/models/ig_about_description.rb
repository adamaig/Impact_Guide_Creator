class IgAboutDescription < ActiveRecord::Base
	validates :text,  presence: true, length: {  maximum: 1024}
end

class GamesController < ApplicationController

	def show
		@game = Game.find(params[:id]).title
		g = Game.where(title: @game)
		@games = ImpactGuide.where(game_id: 0)
		g.each do |x|
			temp = ImpactGuide.where(game_id: x.id)
			@games = @games.merge(temp)
		end
	end

end

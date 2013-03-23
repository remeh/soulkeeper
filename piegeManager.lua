require "piege"
require "totem"
require "repulse"
require "trappe"
require "slowdown"


PiegeManager = {
	currentPiege = nil,

	init = function()
		currentPiege = Piege.new(Piege)
	end,
	changePiege = function(piegeType)	
		currentPiege = Piege.new(piegeType)
	end,

	drawPiegeArea = function()
		local mouseX, mouseY = love.mouse.getX(), love.mouse.getY()
		love.graphics.draw(game.piegeDrawables[currentPiege.class], mouseX,mouseY )
	end	
}

function PiegeManager.new()
	piegeManager = PiegeManager
	piegeManager:init()
	return piegeManager
end

function PiegeManager:mousereleased(x, y, button)
    if button == 'l' then
		local caseX, caseY = Game.level:getCase(x), Game.level:getCase(y)
		if (Game.level.zone[caseY+1][caseX+1] == 1) then
			currentPiege.posX=caseX
			currentPiege.posY=caseY
			Game.level:addTrap(currentPiege)
			Game.level.zone[caseY+1][caseX+1] = 0
		end
    end
end


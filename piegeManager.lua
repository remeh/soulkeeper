require "piege"
require "totem"
require "repulse"
require "trappe"
require "slowdown"


PiegeManager = {
	currentPiege = nil,

	init = function(self)
		--currentPiege = Piege.new(Piege)
		self.currentPiege = nil
	end,
	changePiege = function(self,piegeType)	
		self.currentPiege = Piege.new(piegeType)
	end,

	drawPiegeArea = function(self)
		if self.currentPiege ~= nil then
			local mouseX, mouseY = love.mouse.getX(), love.mouse.getY()
			love.graphics.draw(game.piegeDrawables[self.currentPiege.class], mouseX,mouseY )
		end	
	end
}

function PiegeManager.new()
	piegeManager = PiegeManager
	piegeManager:init(piegeManager)
	return piegeManager
end

function PiegeManager:mousereleased(x, y, button)
    if button == 'l' then
		local caseX, caseY = Game.level:getCase(x), Game.level:getCase(y)
		if (Game.level.zone[caseY+1][caseX+1] == 1 and self.currentPiege ~= nil) then
			self.currentPiege.posX=caseX
			self.currentPiege.posY=caseY
			if	Game.level:addTrap(self.currentPiege) then
				Game.level.zone[caseY+1][caseX+1] = 2
				self.currentPiege = nil
			end
		end
    end
end


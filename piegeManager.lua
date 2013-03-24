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
			local mouseX, mouseY, sp = love.mouse.getX(), love.mouse.getY(),game.level.sprite_size
			for i = (mouseX - self.currentPiege.area*sp + sp), (mouseX +self.currentPiege.area*sp -sp),sp do
				for j = (mouseY - self.currentPiege.area*sp + sp), (mouseY +self.currentPiege.area*sp -sp),sp do
					if (i == mouseX and j == mouseY) then
						love.graphics.draw(game.piegeDrawables[self.currentPiege.class], i,j)
					else
						love.graphics.draw(game.piegeDrawables["zonepiege"], i,j)
					end
				end
			end
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


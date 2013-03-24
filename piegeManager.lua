require "piege"
require "totem"
require "repulse"
require "trappe"
require "slowdown"
require "cage"

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
			self:drawArea(self.currentPiege, mouseX, mouseY)
		end	
	end
}
--Constructor
function PiegeManager.new()
	piegeManager = PiegeManager
	piegeManager:init(piegeManager)
	return piegeManager
end
-- click event for traps
function PiegeManager:mousereleased(x, y, button)
    if button == 'l' then
		local caseX, caseY = Game.level:getCase(x), Game.level:getCase(y)
        if self.currentPiege ~= nil and game.soulCollected >= self.currentPiege.soulNeeded then
            if (Game.level.zone[caseY+1][caseX+1] == 1 and self.currentPiege ~= nil) then
                self.currentPiege.posX=caseX
                self.currentPiege.posY=caseY
                if	Game.level:addTrap(self.currentPiege) then
                    game.soulCollected = game.soulCollected - self.currentPiege.soulNeeded
                    Game.level.zone[caseY+1][caseX+1] = 2
                    self.currentPiege = nil
                end
            end
        end
    end
end
-- Draws a trap and its area
function PiegeManager:drawArea(piege, x, y)
			local  sp = game.level.sprite_size
			for i = (x - piege.area*sp + sp), (x +piege.area*sp -sp),sp do
				for j = (y - piege.area*sp + sp), (y +piege.area*sp -sp),sp do
					if (i == x and j == y) then
						love.graphics.draw(game.piegeDrawables["zonepiege"], i,j)
						love.graphics.draw(game.piegeDrawables[piege.class], i,j)
					else
						love.graphics.draw(game.piegeDrawables["zonepiege"], i,j)
					end
				end
			end
end	


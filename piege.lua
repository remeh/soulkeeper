require "utils"
require "totem"
require "trappe"
require "slowdown"

--

PiegeDrawables ={
	["repulse"] = love.graphics.newImage("sprites/repulse.png"),
	["trappe"] = love.graphics.newImage("sprites/trappe.png"),
	["slowdown"] = love.graphics.newImage("sprites/slowdown.png"),
	["totem"] = love.graphics.newImage("sprites/totem.png"),
	["piege"] = love.graphics.newImage("sprites/NotHere.png")
}

Piege = {
    class = "piege",
    strength = 0,
    soulNeeded = 0,
    posX = -1,
    posY = -1,
    area = 0,
    cooldown = 0,
    walk_on = false,

    -- --------
    -- function shared with implentations
    -- --------
    draw = function(self)
        love.graphics.draw(game.piegeDrawables[self.class], self.posX, self.posY)
    end,
    
    --checks if an object is in the effect area of our trap
    contains = function(self, object)
        local x, y
        if not object.posX then 
            return false 
        end
        if not object.posY then 
            return false 
        end

        if self.posX <= object.posX and object.posX <= self.posX + self.area then 
            x = true 
        end
        if self.posY <= object.posY and object.posY <= self.posY + self.area then 
            y = true 
        end
        if x == true and y == true then 
            return true
        else 
            return false 
        end
    end
}



--default constructor
function Piege.new(trappeType)
	local trappe = deepcopy(Piege)
	
	if trappeType.class then
		trappe.class = deepcopy(trappeType.class)
		trappe.strength = deepcopy(trappeType.strength)
		trappe.soulNeeded = deepcopy(trappeType.soulNeeded)
		trappe.absord_Area = deepcopy(trappeType.absorb_Area)
		trappe.area = deepcopy(trappeType.area)
		trappe.cooldown = deepcopy(trappeType.cooldown)
		trappe.walk_on = deepcopy(trappeType.walk_on)
	end

	return trappe
end




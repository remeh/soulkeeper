require "utils"
require "totem"
require "trappe"
require "slowdown"
require "cage"
--

PiegeDrawables ={
	["repulse"] = love.graphics.newImage("sprites/repulse.png"),
	["trappe"] = love.graphics.newImage("sprites/trappe.png"),
	["slowdown"] = love.graphics.newImage("sprites/smoke.png"),
	["totem"] = love.graphics.newImage("sprites/totem.png"),
	["cage"] = love.graphics.newImage("sprites/cage_empty.png"),
	["cage_full"] = love.graphics.newImage("sprites/cage_full.png"),
	["piege"] = love.graphics.newImage("sprites/NotHere.png"),
	["zonepiege"] = love.graphics.newImage("sprites/OkHere.png"),
}

Piege = {
    class = "piege",
    strength = 0,
    soulNeeded = 5,
    posX = -1,
    posY = -1,
    area = 0,
    cooldown = 0,
    walk_on = false,
    action = nil,

    -- --------
    -- function shared with implentations
    -- --------
    draw = function(self)
        love.graphics.draw(game.piegeDrawables[self.class], self.posX, self.posY)
    end,
    
    --checks if an object is in the effect area of our trap
    contains = function(self, object)
        if not object.posX then 
            return false 
        end
        if not object.posY then 
            return false 
        end

        if math.abs(self.posX - object.posX)  < self.area then
            if math.abs(self.posY - object.posY) < self.area then
                return true
            end
        end
        return false
    end
}



--default constructor
function Piege.new(trappeType)
	local trappe = deepcopy(Piege)
	
	if trappeType.class then
		trappe.class = deepcopy(trappeType.class)
		trappe.strength = deepcopy(trappeType.strength)
		trappe.soulNeeded = deepcopy(trappeType.soulNeeded)
		trappe.area = deepcopy(trappeType.area)
		trappe.cooldown = deepcopy(trappeType.cooldown)
		trappe.walk_on = deepcopy(trappeType.walk_on)
        trappe.action = deepcopy(trappeType.action)
		if trappeType.class == "cage" then
			trappe.actorCaged = trappeType.actorCaged --ref
		end
	end

	return trappe
end




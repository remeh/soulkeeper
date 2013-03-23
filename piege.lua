require "utils"
require "totem"
require "trappe"
require "slowdown"

Piege = {
    class = "piege",
    strength = 0,
    soulNeeded = 0,
    pos_x = -1,
    pos_y = -1,
    absorb_Area = 0,
    effect_Area = 0,
    cooldown = 0,
    walk_on = false

}

function Piege.new(trappeType)
	trappe = deepcopy(Piege)
	
	if trappeType.class then
		trappe.class = deepcopy(trappeType.class)
		trappe.strength = deepcopy(trappeType.strength)
		trappe.soulNeeded = deepcopy(trappeType.soulNeeded)
		trappe.absord_Area = deepcopy(trappeType.absorb_Area)
		trappe.effect_Area = deepcopy(trappeType.effect_Area)
		trappe.cooldown = deepcopy(trappeType.cooldown)
		trappe.walk_on = deepcopy(trappeType.walk_on)
	end

	return trappe
end

function Piege:contains(object)
   local x, y
   if not object.x then 
      return false 
   end
   if not object.y then 
      return false 
   end
   if self.pos_x < object.posX and object.posX < object.pos_x + object.area then 
      x = true 
   end
   if self.pos_y < object.posY and object.posY < object.pos_y + object.area then 
      y = true 
   end
   if x == true and y == true then 
      return true
   else 
      return false 
   end
end


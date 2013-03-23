Piege = {
    class = "piege"
    strength = 0,
    soulNeeded = 0,
    pos_x = -1,
    pos_y = -1,
    absorb_Area = 0,
    effect_Area = 0,
    cooldown = 0,
    walk_on = false

}

function Trappe:new(trappeType)
	trappe = Piege
	
	if trappeType.class then
		trappe.class = trappeType.class
		trappe.strength = trappeType.strength
		trappe.soulNeeded = trappeType.soulNeeded
		trappe.absord_Area = trappeType.absorb_Area
		trappe.effect_Area = trappeType.effect_Area
		trappe.cooldown = trappeType.cooldown
		trappe.walk_on = trappeType.walk_on
	end
	return trappe
end

function Trappe:contains(object)
   local x, y
   if not object.x then 
      return false 
   end
   if not object.y then 
      return false 
   end
   if self.pos_x < object.pos_x and object.pos_x < object.pos_x + object.area then 
      x = true 
   end
   if self.pos_y < object.pos_y and object.pos_y < object.pos_y + object.area then 
      y = true 
   end
   if x == true and y == true then 
      return true
   else 
      return false 
   end
end


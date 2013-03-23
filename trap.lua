Trappe = {
    type = "trappe",
    strength = 100,
    soulNeeded = 3,
    pos_x = -1,
    pos_y = -1,
    Absorb_Area = 4,
    effect_Area = 1,
    couldown = 2,
    walk_on = true
}

Totem = {
    type = "totem",
    strength = 0,
    soulNeeded = 3,
    pos_x = -1,
    pos_y = -1,
    Absorb_Area = 4,
    effect_Area = 4,
    couldown = 2,
    walk_on = false
}

Slow_Down = {
    type = "slow_down",
    strength = 0,
    soulNeeded = 3,
    pos_x = -1,
    pos_y = -1,
    Absorb_Area = 4,
    effect_Area = 4,
    couldown = 2,
    walk_on = true
}

Repulse = {
    type = "repulse",
    strength = 0,
    soulNeeded = 3,
    pos_x = -1,
    pos_y = -1,
    Absorb_Area = 4,
    effect_Area = 2,
    couldown = 2,
    walk_on = true
}

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


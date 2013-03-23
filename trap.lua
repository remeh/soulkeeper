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

function Trappe:trigger(actor)
   love.graphics.setBackgroundcolor(255, 255, 255)
   love.graphics.setcolor(255, 0, 0)
end

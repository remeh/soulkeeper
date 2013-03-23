Totem = {
    class = "totem",
    strength = -1,
    soulNeeded = 3,
    absorb_Area = 4,
    effect_Area = 4,
    cooldown = 2,
    walk_on = false,

    actorAction = function(self, actor)
    	self.speed = 0
        self.class = "soul"
    end
}

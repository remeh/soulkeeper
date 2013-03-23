Trappe = {
    class = "trappe",
    strength = 100,
    soulNeeded = 2,
    absorb_Area = 4,
    effect_Area = 3,
    couldown = 2,
    walk_on = true,

    actorAction = function(self, actor)
    	self.health = self.health - 100
    end
}

Trappe = {
    class = "trappe",
    strength = 100,
    soulNeeded = 3,
    absorb_Area = 4,
    effect_Area = 1,
    couldown = 2,
    walk_on = true

    actorAktion = function(actor)
    	self.health = self.health - 100
    end
}

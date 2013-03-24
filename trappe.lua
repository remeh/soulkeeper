Trappe = {
    class = "trappe",
    strength = 100,
    soulNeeded = 1,
    effect = 1,
    couldown = 2,
    walk_on = true,

    action = function(self, actor)
    	self.health = self.health - 100
    end
}

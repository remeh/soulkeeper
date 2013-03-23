Trappe = {
    class = "trappe",
    strength = 100,
    soulNeeded = 2,
    area = 2,
    couldown = 2,
    walk_on = true,

    actorAction = function(self, actor)
    	self.health = self.health - 100
    end
}

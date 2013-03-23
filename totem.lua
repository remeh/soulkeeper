Totem = {
    class = "totem",
    strength = -1,
    soulNeeded = 1,
    area = 4,
    cooldown = 2,
    walk_on = false,

    actorAction = function(self, actor)
    	self.speed = 0
        self.class = "soul"
    end
}

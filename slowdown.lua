Slowdown = {
    class = "slowdown",
    strength = 1,
    soulNeeded = 2,
    area = 3,
    cooldown = 1,
    walk_on = false,

    action = function(self, actor)
		actor.timeToUpdate = 1
    end
}

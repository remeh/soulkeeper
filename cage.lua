Cage = {
	class = "cage",
	strength = 100,
	soulNeeded = 5,
	area = 1,
	cooldown = 2,
	walk_on = true,
	actorCaged = nil,

	action = function(self, actor)
		if  self.class ~= "cage_full" then
			actor.timeCaged = 33 
			actor.isBlocked = true
			actor.cage = self
			self.actorCaged = actor
			self.class = "cage_full"
		else
			if self.actorCaged ~= actor then
				self.class = "cage"
				self.actorCaged.timeCaged = -1
				self.actorCaged.isBlocked = false
				game.level:removeTrap(self)
			end
		end
	end


}

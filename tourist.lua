Tourist = {
    class = "Soul",

    update = function(self, delta)
		self.lastUpdate = self.lastUpdate + delta
		if self.lastUpdate >= self.timeToUpdate then
			self.lastUpdate = 0
		end
        -- TODO
    end,

    die = function(self, delta)
        -- TODO
    end,
}


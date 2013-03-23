Tourist = {
    class = "Tourist",

    update = function(self, delta)
		self.lastUpdate = self.lastUpdate + delta
		if self.lastUpdate >= self.timeToUpdate then
			if self.terror then
			end
			self.lastUpdate = 0

			print("BOUBOUP")
		end
        -- TODO
    end,

    die = function(self, delta)
        -- TODO
    end,
}


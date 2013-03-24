-- -------
-- Soul class definition.
-- -------

Soul = {
    class = "Soul",
    health = 1000,

    update = function(self, delta)
        self.health = self.health - 1
        if self.health <= 0 then
            game.level:removePerson(self)
        end
    end,

    die = function(self, delta)
        -- TODO
    end,
}


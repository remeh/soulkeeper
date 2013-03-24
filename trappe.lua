require "actor"
require "dead"

Trappe = {
    class = "trappe",
    strength = 100,
    soulNeeded = 3,
    area = 1,
    cooldown = 2,
    walk_on = true,

    action = function(self, actor)
        -- removes the tourist
        game.level:removePerson(actor)
    end
}

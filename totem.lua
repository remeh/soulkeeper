require "actor"
require "soul"

Totem = {
    class = "totem",
    strength = -1,
    soulNeeded = 1,
    area = 2,
    cooldown = 2,
    walk_on = false,

    action = function(self, actor)
        -- creates the soul
        local soul = Actor.new(Soul)
        soul.posX = actor.posX
        soul.posY = actor.posY
        -- adds it in the levle
        game.level:addPerson(soul)

        game.point = game.point + 20

        -- removes the tourist
        game.level:removePerson(actor)
	game.wave = game.wave - 1
    end
}

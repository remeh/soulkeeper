require "actor"
require "soul"

Totem = {
    class = "totem",
    strength = -1,
    soulNeeded = 5,
    area = 2,
    cooldown = 2,
    walk_on = false,

    action = function(self, actor)
        -- creates the soul
        local soul = Actor.new(Soul)
        soul.posX = actor.posX
        soul.posY = actor.posY
        -- adds it in the level
        game.level:addPerson(soul)
        game.soulCollected = game.soulCollected + 1

        game.point = game.point + 20

        -- removes the tourist
        game.level:removePerson(actor)
    end
}

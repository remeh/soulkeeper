Trappe = {
    class = "trappe",
    strength = 100,
    soulNeeded = 2,
    area = 2,
    couldown = 2,
    walk_on = true,

    action = function(self, actor)
        -- TODO faire un truc montnrant qu'il est mort

        -- removes the tourist
        game.level:removePerson(actor)
    end
}

-- -------
-- Indian class definition.
-- -------

Indian = {
    class = "Indian",
    
    -- consts
    CHANCE_TO_WALK = 10,

    -- implementation of Actor
    update = function(self, delta)
        -- move in level
        self:move(delta)
    end,

    die = function(self, delta)
        -- TODO
    end,

    -- specifity of Indian
    move = function(self, delta)
        if math.random(100) > (100-Indian.CHANCE_TO_WALK) then

            if game.level.isBlocking() then
                print("Indian is moving")
            end
        end
    end
}


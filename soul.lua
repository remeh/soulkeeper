-- -------
-- Soul class definition.
-- -------

Soul = {
    class = "Soul",
    health = 15,
    CHANCE_TO_WALK = 8,

    update = function(self, delta)
        self.health = self.health - 1*delta
        if self.health <= 0 then
            game.level:removePerson(self)
        end

        -- move
        if math.random(100) > (100-Soul.CHANCE_TO_WALK) then
            local direction = math.random(4)
            local dx = 0
            local dy = 0

            if direction == Direction.UP then
                dy = -(math.random(100)%2)
            elseif direction == Direction.RIGHT then
                dx = (math.random(100)%2)
            elseif direction == Direction.DOWN then
                dy = (math.random(100)%2)
            else
                dx = -(math.random(100)%2)
            end

            if not game.level:isBlocking(self.posX+dx, self.posY+dy) and not game.level:isOutside(self.posX + dx, self.posY + dy) then
                self.posX = self.posX + dx
                self.posY = self.posY + dy
            end
        end
    end,

    die = function(self, delta)
        -- TODO
    end,
}


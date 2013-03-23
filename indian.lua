-- -------
-- Indian class definition.
-- -------

Indian = {
    class = "Indian",
    
    -- consts
    CHANCE_TO_WALK = 4,

    die = function(self, delta)
        -- TODO
    end,

    -- specifity of Indian
    move = function(self, delta)
        if math.random(100) > (100-Indian.CHANCE_TO_WALK) then
            local direction = math.random(4)
            local dx = 0
            local dy = 0
	    local prec = 0

            if direction == Direction.UP and prec ~= Direction.UP then
                dy = -(math.random(100)%2)
            elseif direction == Direction.RIGHT and prec ~= Direction.RIGHT then
                dx = (math.random(100)%2)
            elseif direction == Direction.DOWN and prec ~= Direction.DOWN then
                dy = (math.random(100)%2)
            elseif prec ~= Direction.LEFT then 
                dx = -(math.random(100)%2)
            end

            if not game.level:isBlocking(self.posX+dx, self.posY+dy) and not game.level:isOutside(self.posX + dx, self.posY + dy) then
                self.posX = self.posX + dx
                self.posY = self.posY + dy
            end
        end
    end,

    -- implementation of Actor
    update = function(self, delta)
        -- move in level
        self:move(delta)
        -- 
        self:forceTrapMovement()
        -- 
        entityTouching = game.level.touches(self)
    end
}


require "indian"
require "soul"
require "tourist"

--
--
--

ActorDrawables = {
    ["Indian"] = love.graphics.newImage("sprites/indian.png"),
    ["Soul"] = love.graphics.newImage("sprites/soul.png")
}

-- ---
-- Actors definition
-- ---

Actor = {
    -- class members
    posX = 0,
    posY = 1,
    visible = true,
    health = 1,
    area = 1,
    class = "Actor",

    -- function shared with implentations
    draw = function(self)
        love.graphics.draw(game.actorDrawables[self.class], self.posX, self.posY)
    end,

    -- function to implements
    update = nil,
    die = nil,
}

-- ---
-- Methods
-- ---

-- Init an actor to a type.
function Actor:init(actorType)
    
    -- simple inheritance system

    if actorType ~= Actor then
        self.class = actorType.class
        self.update = actorType.update
    end

end

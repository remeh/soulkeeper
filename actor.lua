require "indian"
require "soul"
require "tourist"

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
    visible = true,
    health = 1,
    area = 1,
    class = "Actor",

    posX = 0,
    posY = 1,
    -- function shared with implentations
    draw = function(self)
        love.graphics.draw(game.actorDrawables[self.class], self.posX, self.posY)
    end,

    contains = function(self, other)
	  if math.abs(self.posX - other.posX) 
	     < actor.area then
	     if math.abs(self.posY - other.posY) 
	     	< actor.area then
		return true
	     end
	  end
	return false
    end,

    touch = function(self, other)
    	  if math.abs(actor.posX - other.posX)
	     < 1 then
	     if math.abs(actor.posY - other.posY)
	       	< 1 then
	  	return true
	     end
	  end
	return false
    end,

    -- function to implements
    update = nil,
    die = nil,
}

-- ---
-- Methods
-- ---

-- Constructor

function Actor.new(actorType)
    -- simple inheritance system
    actor = Actor

    if actorType.class ~= "Actor" then
        actor.class  = actorType.class
        actor.update = actorType.update
    end

    return actor
end

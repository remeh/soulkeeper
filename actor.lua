require "indian"
require "soul"
require "tourist"
require "utils"

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
    forceMoveX = 0, -- modified by a trap when the actor MUST move
    forceMoveY = 0, -- modified by a trap when the actor MUST move
    class = "Actor",

    posX = 0,
    posY = 1,

    -- --------
    -- function shared with implentations
    -- --------
    draw = function(self)
        love.graphics.draw(game.actorDrawables[self.class], self.posX, self.posY)
    end,

    -- force the movement if a trap have ordered to
    forceTrapMovement = function(self)
        local dx = 0
        local dy = 0
        if forceMoveX ~= 0 then
            dx = forceMoveX/forceMoveX
        end
        if not game.level.isBlocking(posX+dx, posY) then
            posX = posX + dx 
        end

        if forceMoveY ~= 0 then
            dy = forceMoveY/forceMoveY
        end
        if not game.level.isBlocking(posX, posY+dy) then
            posY = posY + dy
        end
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
    actor = deepcopy(Actor)

    if actorType.class ~= "Actor" then
        actor.class  = deepcopy(actorType.class)
        actor.update = deepcopy(actorType.update)
    end

    return actor
end

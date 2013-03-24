require "utils"

Repulse = {
    class = "repulse",
    strength = 4,
    soulNeeded = 4,
    area = 2,
    cooldown = 2,
    walk_on = true,

	--	we re forcing the actor to go towards a specific location
	action = function (self, actor)
        if (not self.posX or not self.posY) then
            return nil
        end

        local centreX, centreY = 20, 15
        local targetX, targetY
        local topDoorX, topDoorY = centreX, 0
        local bottomDoorX, bottomDoorY = centreX, centreY*2
        local leftDoorX, leftDoorY = 0, centreY
        local rightDoorX, rightDoory = centreX*2, centreY
        local topDist, bottomDist, leftDist, rightDist

        --calculating the closest door/path
        topDist = distanceFrom(self.posX, self.posY, topDoorX, topDoorY)	
        bottomDist = distanceFrom(self.posX, self.posY, bottomDoorX, bottomDoorY)
        leftDist = distanceFrom(self.posX, self.posY, leftDoorX, leftDoorY)
        rightDist = distanceFrom(self.posX, self.posY, rightDoorX, rightDoorY)
        
        local minDist=1000000
        for i in topDist, bottomDist, rightDist, leftDist do
            if i < minDist then
                minDist = i
            end
        end
        if minDist == topDist then
            targetX=topDoorX
            targetY=topDoorY
        end
        if minDist == bottomDist then
            targetX=bottomDoorX
            targetY=bottomDoorY
        end
        if minDist == leftDist then
            targetX=leftDoorX
            targetY=leftDoorY
        end
        if minDist == rightDist then
            targetX=rightDoorX
            targetY=rightDoorY
        end

        -- TODO checks that it will not be propulsed to far
        -- applies this force to the actor
        actor.forceMoveX = targetX-actor.posX
        actor.forceMoveY = targetY-actor.posY
	end
}

require "utils"

Repulse = {
    class = "repulse"
    strength = 4,
    soulNeeded = 3,
    absorb_Area = 3,
    effect_Area = 2,
    cooldown = 2,
    walk_on = true

    --On force l'acteur à se déplacer vers un point
    actorAction = function (actor, self)
	
	if (not self.pos_x or not self.pos_y) then
		return nil
	end

	local centreX, centreY = 20, 15
	local targetX, targetY
	local topDoorX, topDoorY = centreX, 0
	local bottomDoorX, bottomDoorY = centreX, centreY*2
	local leftDoorX, leftDoorY = 0, centreY
	local rightDoorX, rightDoory = centreX*2, centreY
	local topDist, bottomDist, leftDist, rightDist

	topDist = distanceFrom(self.pos_x, self.pos_y, topDoorX, topDoorY)	
	bottomDist = distanceFrom(self.pos_x, self.pos_y, bottomDoorX, bottomDoorY)
	leftDist = distanceFrom(self.pos_x, self.pos_y, leftDoorX, leftDoorY)
	rightDist = distanceFrom(self.pos_x, self.pos_y, rightDoorX, rightDoorY)
	
	local minDist=1000000
	for i = topDist, bottomDist, rightDist, leftDist do
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
	end
}

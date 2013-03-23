Gameplay = {
    seconds = 0,
    lastTime = 0
}

--

-- update the seconds
function Gameplay:update(delta)
    self:updateTime(delta)
    -- TODO vague must be configurable or read in the game state
    if self.seconds > 10 then
        self:newWave()
        self.seconds = 0
    end
end

function Gameplay:updateTime(delta)
    local currentTime = love.timer.getTime()
    local delta = currentTime - self.lastTime
    if delta >= 1 then
        self.seconds = self.seconds + delta
        self.lastTime = currentTime
    end
end

function Gameplay:newWave()
    -- put tourists on the road
    local result = game.level:findRoad()
    print("new tourist on : " .. result.findX .. ":" .. result.findY)
end

-- Constructor
function Gameplay.new()
    local gameplay = Gameplay
    return gameplay
end


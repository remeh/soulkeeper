require "actor"
require "piege"
require "piegeManager"
require "level"
require "menu"
require "consts"

-- The main game method which will contains
-- the different states.
Game = {
    -- starting state
    state = GameState.MAIN_MENU,
    -- the level instance
    level = Level.new(30, 30, 16, 1),
    -- the menu
    menu = Menu.new(),
    -- background music
--    backgroundMusic = love.audio.newSource("sounds/SoulKeeper.mp3"),

    actorDrawables = ActorDrawables,
    piegeDrawables = PiegeDrawables,
	--init piegeManager
	piegeManager = PiegeManager.new() 
}

function Game:update(delta)
    local switch = {
        [GameState.MAIN_MENU] = function(delta) self:updateMainMenu(delta) end,
        [GameState.GAME_SCREEN] = function(delta) self:updateGameScreen(delta) end,
        [GameState.GAME_OVER] = function(delta) self:updateGameOver(delta) end
    }
    -- call the switch
    switch[self.state](delta)
end

function Game:draw()
    local switch = {
        [GameState.MAIN_MENU] = function() self:menuDraw() end,
        [GameState.GAME_SCREEN] = function() self:levelDraw() end,
        [GameState.GAME_OVER] = function() self:gameOverDraw() end
    }
    -- call the switch
    switch[self.state](delta)

end

function Game:keypressed(key, unicode)
    local switch = {
        [GameState.MAIN_MENU] = function() self:keypressedMainMenu(key) end,
        [GameState.GAME_SCREEN] = function() self:keypressedGameScreen(key) end,
        [GameState.GAME_OVER] =  function() self:keypressedGameOver(key) end
    }
    -- call the switch
    switch[self.state](delta)
end

function Game:keypressedMainMenu(key)

end

function Game:keypressedGameScreen(key)
    print(key)
    if key == 'a' then
        local soul = Actor.new(Soul)
        self.level:addPersonRandomly(soul)
    end
end

function Game:keypressedGameOver(key)

end

function Game:mousereleased(x, y, button)
	print("X : " .. x .. " Y : " .. y .. " BT : " .. button)
    local switch = {
        [GameState.MAIN_MENU] = function(x,y,button) self:mousereleasedMainMenu(x, y, button) end,
        [GameState.GAME_SCREEN] = function(x,y,button) self:mousereleasedGameScreen(x, y, button) end,
        [GameState.GAME_OVER] = function(x,y,button) self:mousereleasedGameOver(x, y, button) end
    }
    -- call the switch
    switch[self.state](x, y, button)
end

function Game:menuDraw()
    self.menu:draw()
end

function Game:levelDraw()
    self.level:draw()
end

function Game:gameOverDraw()
    -- TODO
end

function Game:updateMainMenu(delta)
end

function Game:updateGameScreen(delta)
    -- update the level
    self.level:update(delta)
end

function Game:updateGameOver(delta)
end

function Game:mousereleasedMainMenu(x, y, button)
	self.menu:mousereleased(x,y,button)
end

function Game:mousereleasedGameScreen(x, y, button)
end

function Game:mousereleasedGameOver(x, y, button)
end


-- Constructor
function Game.new()
    local game = Game
    game.state = GameState.GAME_SCREEN

    --
    math.randomseed(os.time())

    -- Launches the music
--    game.backgroundMusic:setLooping(true)
--    game.backgroundMusic:setVolume(0.7)
--    game.backgroundMusic:play()

    return game
end

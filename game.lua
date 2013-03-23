require "actor"
require "level"
require "menu"
require "consts"

-- The main game method which will contains
-- the different states.
Game = {
    -- starting state
    state = GameState.MAIN_MENU,
    -- the level instance
    level = Level.new(30, 40, 16, 1), -- TODO see for the number entrance
    -- the menu
    menu = Menu.new(),
    -- background music
    backgroundMusic = love.audio.newSource("sounds/SoulKeeper.mp3"),

    actorDrawables = ActorDrawables
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

function Game:menuDraw()
    menu:draw()
end

function Game:levelDraw()
    level:draw()
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

-- Constructor
function Game.new()
    local game = Game
    game.state = "main_menu"
    return game
end

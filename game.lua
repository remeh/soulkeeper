require "actor"
require "level"
require "menu"

-- The main game method which will contains
-- the different states.
Game = {
    -- starting state
    state = "main_menu",
    -- the level instance
    level = Level.new(30, 40, 16, 1), -- TODO see for the number entrance
    -- the menu
    menu = Menu.new(),

    actorDrawables = ActorDrawables
}

function Game:update(delta)
    local switch = {
        ["main_menu"] = function (delta) self:updateMainMenu(delta) end,
        ["game_screen"] = function (delta) self:updateGameScreen(delta) end,
        ["game_over"] = function (delta) self:updateGameOver(delta) end
    }
    -- call the switch
    switch[self.state](delta)
end

function Game:draw()
    local switch = {
        ["main_menu"] = function () self:menuDraw() end,
        ["game_screen"] = function () self:levelDraw() end,
    }
    -- call the switch
    switch[self.state](delta)
end

function Game:keypressed(key, unicode)
end

function Game:menuDraw()
    menu:draw()
end

function Game:levelDraw()
    self.level:draw()
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
    game.state = "game_screen"
    return game
end

require "mini_menu"
require "actor"
require "piege"
require "piegeManager"
require "level"
require "menu"
require "consts"
require "gameplay"
require "menuGameOver"

-- The main game method which will contains
-- the different states.
Game = {
	alpha = love.graphics.newImage("sprites/screen_alpha.png"),
    -- starting state
    state = GameState.MAIN_MENU,
    -- the level instance
    level = Level.new(30, 30, 16, 1),
    -- the menu
    minimenu = Minimenu.new(),
    menu = Menu.new(),
	menuGameOver = MenuGameOver.new(),
    -- background music
    backgroundMusic = love.audio.newSource("sounds/SoulKeeper.ogg"),
    gameplay = Gameplay.new(),
    -- amount of souls collected to create a totem.
    soulCollected = 20,

    actorDrawables = ActorDrawables,
    piegeDrawables = PiegeDrawables,
	--init piegeManager
	piegeManager = PiegeManager.new(), 
	paused = 0,
	started = 0,

	point = 0,
}

function Game:createdLevel(difficult)
	self.level.persons = {}
	self.level.traps = {}
	self.point = 0
    self.soulCollected = 20
	self.level = Level.new(30,30,16,difficult)
end

function Game:switchPause()
	if self.paused == 1 then
		self.paused = 0
	else
		self.paused = 1
	end
end

function Game:update(delta)
    local switch = {
        [GameState.MAIN_MENU] = function(delta) self:updateMainMenu(delta) end,
        [GameState.GAME_SCREEN] = function(delta) self:updateGameScreen(delta) end,
        [GameState.GAME_OVER] = function(delta) self:updateGameOver(delta) end
    }
    -- call the switch
	if self.paused == 0 then
		switch[self.state](delta)
		if self.started == 1 and self.state ~= GameState.GAME_OVER then
			self.point = self.point + delta
		end
	end
end

function Game:draw()
    local switch = {
        [GameState.MAIN_MENU] = function() self:menuDraw() end,
        [GameState.GAME_SCREEN] = function() self:levelDraw() end,
        [GameState.GAME_OVER] = function() self:gameOverDraw() end
    }
    -- call the switch
    switch[self.state](delta)
    if self.paused == 1 then
		love.graphics.draw(self.alpha)
		love.graphics.setFont(Menu.fonts[3])
		love.graphics.print("Pause", 150, 185)
    end
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
    if key == 'escape' then
        love.event.quit()
    end
end

function Game:keypressedGameScreen(key)
    if key == 'a' then
        local soul = Actor.new(Soul)
        self.level:addPersonRandomly(soul)
    elseif key == 'escape' then
        self:switchPause()
	elseif key == 'q' and self.paused == 1 then
		love.event.quit()
	elseif key == 'o' and self.paused == 1 then
		self:switchPause()
		self.state = GameState.GAME_OVER
	elseif key == 't' then
		piegeManager.changePiege(piegeManager, Totem)
    end
end

function Game:keypressedGameOver(key)
end

function Game:mousereleased(x, y, button)
	--print("X : " .. x .. " Y : " .. y .. " BT : " .. button)
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
    self.minimenu:draw()
end

function Game:gameOverDraw()
	self.menuGameOver:draw()
end

function Game:updateMainMenu(delta)
	self.menu:update(delta)
end

function Game:updateGameScreen(delta)
    -- update the gameplay
    self.gameplay:update(delta)
    -- update the level
    self.level:update(delta)
end

function Game:updateGameOver(delta)
	self.menuGameOver:update(delta)
end

function Game:mousereleasedMainMenu(x, y, button)
	self.menu:mousereleased(x,y,button)
end

function Game:mousereleasedGameScreen(x, y, button)
	self.piegeManager:mousereleased(x, y, button)
	self.minimenu:mousereleased(x, y, button)
end

function Game:mousereleasedGameOver(x, y, button)
	self.menuGameOver:mousereleased(x,y,button)
end

-- Constructor
function Game.new()
    local game = Game
    game.state = GameState.MAIN_MENU

    --
    math.randomseed(os.time())

    -- Launches the music
    game.backgroundMusic:setLooping(true)
    game.backgroundMusic:setVolume(1.0) 
    game.backgroundMusic:play()
    
    return game
end

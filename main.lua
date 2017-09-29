--main file at root controlling loading of states
function clearLoveCallbacks() -- clear all of the love modules to not mix with different states
	love.draw = nil
	love.joystickpressed = nil
	love.joystickreleased = nil
	love.keypressed = nil
	love.keyreleased = nil
  love.load = nil
	love.mousepressed = nil
	love.mousereleased = nil
  love.update = nil
  
end

function load() -- load function
end

state = {}

function loadState(name) -- load a state
  clearLoveCallbacks()
  local path = "states/" .. name
  require(path .. "/main")() -- requires a file and then loads the function
  load() -- loads whats in the function
end



function love.load() -- love callback function to be run on startup
	loadState("titlescreen") -- load titlescreen straight away
end
	
function love.draw() -- love callback function to draw every frame
end

function love.update(dt) -- love callback function to update every frame
end

function love.keypressed(key, unicode) -- love callback function when a key is pressed, the key in the argument is the key pressed
end

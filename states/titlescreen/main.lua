-- title screen file
return function () -- return function called by the loadstate function in the require line 
function load()
  love.graphics.setBackgroundColor(0, 0, 0)
  titlecard = love.graphics.newImage("assets/titlecard.png")   -- initialising title card image
  pressEnter = love.graphics.newImage("assets/pressenter.png") -- more images
end

function love.draw()
  local height = love.graphics.getHeight()
  local width = love.graphics.getWidth()
  love.graphics.draw(titlecard, width/2, height/2 - 256, 0, 1, 1, 1024/2, 128/2) -- drawing the images
  love.graphics.draw(pressEnter, width/2, height/2, 0, 1, 1, 256/2, 64/2)
end

function love.update()
  
end

function love.keypressed(key)
  if key == "return" then -- pressing enter loads the menu state
    loadState("Menu")
  end
end
end

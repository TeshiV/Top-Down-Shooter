-- map file
map =                                     -- initialising map table, with walls with their positional values stored
{
  walls =
  {
    wall1 =
    {
      id = 1, x = 100, y = -4000, w = 32, h = 8000, block = "left"
    },
    wall2 =
    {
      id = 2, x = 100, y = -4000, w = 8000, h = 32, block = "up"
    },
    wall3 =
    {
      id = 3, x = 8100, y = -4000, w = 32, h = 8000, block = "right"
    },
    wall4 =
    {
      id = 4, x = 100, y = 4000, w = 8000, h = 32, block = "down"
    },
    wall5 =
    {
      id = 5, x = 100, y = -3800, w = 400, h = 32, block = "down"
    },
    wall6 =
    {
      id = 6, x = 100, y = -3795, w = 400, h = 32, block = "up"
    },
    wall7 =
    {
      id = 7, x = 100, y = -3795, w = 405, h = 27, block = "left"
    },
    wall8 =
    {
      id = 8, x = 600, y = -4000, w = 32, h = 232, block = "right"
    },
    wall9 =
    {
      id = 9, x = 605, y = -4000, w = 32, h = 232, block = "left"
    },
    wall10 =
    {
      id = 10, x = 605, y = -4000, w = 27, h = 237, block = "up"
    }
  },
  goals =
  {
    goal1 =
    {
      id = 1, x = 720, y = 320, w = 32, h = 32, action = "next stage"
    }
  }
}

function drawWalls(x, y, w, h) -- function to draw the map walls
  love.graphics.setColor(50, 50, 200, 255)
  love.graphics.rectangle("fill", x, y, w, h)
end

function drawGoals(x, y, w, h)
  love.graphics.setColor(20, 20, 220, 255)
  love.graphics.rectangle("fill", x, y, w, h)
end

function updateWalls()       -- function that constantly checks which walls the player is in contact with and which movement direction to restrict
  player.canwalk.up = true
  player.canwalk.down = true
  player.canwalk.left = true  -- makes sure the player can walk before checking for collisions, otherwise the player can walk through walls if this is done inside the for loop
  player.canwalk.right = true
  for i,v in pairs(map.walls) do
    local px,py = player:getPos()
    local pxo, pyo = player:getOffset()
    local x, y, w, h, block = v.x, v.y, v.w, v.h, v.block
    local col = checkCollision(px-pxo, py-pyo, player.width, player.height, x, y, w, h)
    if col == true then
      if block == "left" then              -- if the wall blocks left movement and the player is in contact with that wall
        player.canwalk.left = false        -- dont allow the player to move left etc etc

      elseif block == "up" then
        player.canwalk.up = false

      elseif block == "down" then
        player.canwalk.down = false

      elseif block == "right" then
        player.canwalk.right = false
      end
    end
  end
end

function goalsUpdate()
  local x,y = player:getPos()
  local xo, yo = player:getOffset()
  local w, h = player:getDimensions()

  for i,v in pairs(map.goals) do
    if checkCollision(x-xo, y-yo, w, h, v.x, v.y, v.w, v.h) then
      if v.action == "next stage" then

      end
    end
  end
end

function map:draw() -- map draw function that is called in the main.lua file
  local i,v
  for i,v in pairs(map.walls) do
    drawWalls(v.x, v.y, v.w, v.h)
  end
  for i,v in pairs(map.goals) do
    drawGoals(v.x, v.y, v.w, v.h)
  end
end

function map:update(dt)
  updateWalls(dt)
  goalsUpdate()
end

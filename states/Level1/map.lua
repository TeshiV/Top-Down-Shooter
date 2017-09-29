-- map file
map =                                     -- initialising map table, with walls with their positional values stored
{
  walls =
  {
    wall1 =
    {
      id = 1, x = 100, y = 605, w = 190, h = 35, block = "up"
    },
    wall2 =
    {
      id = 2, x = 260, y = 445, w = 35, h = 190, block = "left"
    },
    wall3 =
    {
      id = 3, x = 100, y = 735, w = 300, h = 35, block = "down"
    },
    wall4 =
    {
      id = 4, x = 65, y = 605, w = 35, h = 165, block = "left"
    },
    wall5 =
    {
      id = 5, x = 400, y = 590, w = 35, h = 180, block = "right"
    },
    wall6 =
    {
      id = 6, x = 405, y = 585, w = 35, h = 35, block = "down"
    },
    wall7 =
    {
      id = 7, x = 440, y = 550, w = 35, h = 70, block = "right"
    },
    wall8 =
    {
      id = 8, x = 405, y = 515, w = 70, h = 35, block = "up"
    },
    wall9 =
    {
      id = 9, x = 400, y = 395, w = 35, h = 150, block = "right"
    },
    wall10 =
    {
      id = 10, x = 220, y = 440, w = 70, h = 35, block = "down"
    },
    wall11 =
    {
      id = 11, x = 220, y = 405, w = 35, h = 35, block = "left"
    },
    wall12 =
    {
      id = 12, x = 220, y = 370, w = 70, h = 35, block = "up"
    },
    wall13 =
    {
      id = 13, x = 260, y = 250, w = 35, h = 150, block = "left"
    },
    wall14 =
    {
      id = 14, x = 260, y = 250, w = 505, h = 35, block = "up"
    },
    wall15 =
    {
      id = 15, x = 405, y = 395, w = 355, h = 35, block = "down"
    },
    wall16 =
    {
      id = 16, x = 755, y = 250, w = 35, h = 180, block = "right"
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

function goalsUpdate()               -- function which checks if a player touches the goal
  local x,y = player:getPos()
  local xo, yo = player:getOffset()
  local w, h = player:getDimensions()
  for i,v in pairs(map.goals) do
    if checkCollision(x-xo, y-yo, w, h, v.x, v.y, v.w, v.h) then
      for k,p in ipairs(grunt.bodies) do  -- these for loops are removing all objects in the game before loading the map data for the next area
        if p.life == false or p.seen == false then -- this doesnt allow the player to progress to the next level if they are seen and the enemy are in alert mode
          if v.action == "next stage" then
            table.remove(grunt.bodies, k)
            for m,j in ipairs(ammo.items) do
                table.remove(ammo.items, m)
            end
            for l,t in ipairs(healthpack.items) do
                table.remove(healthpack.items, l)
            end
            loadState("level2")
          end
        end
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

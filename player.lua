-- player file
player =
{                     --initialisation of the player class
  name = "Salad Snack",
  health = 500,
  maxhealth = 500,
  xposition = 130,
  yposition = 700,
  velocity = 250,
  height = 32,
  width = 25,
  gun = "M4",
  life = true,
  state = "still",
  input = true,
  mousey = love.mouse.getY(),
  mousex = love.mouse.getX(),
  canshoot = true,
  xoffset = 11,
  yoffset = 17,
  canwalk =
  {
    up = true,
    down = true,
    left = true,
    right = true
  }
}

function player:new(o) -- function to create a new object from player class
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function player:getName()                                -- start of get methods
  return self.name
end

function player:getHealth()
  return self.health
end

function player:getmaxHealth()
  return self.maxhealth
end

function player:getPos()
  return self.xposition, self.yposition
end

function player:getDimensions()
  return self.width, self.height
end

function player:getGun()
  return self.gun
end

function player:getLife()
  return self.life
end

function player:getState()
  return self.state
end

function player:getVelocity()
  return self.velocity
end

function player:getInput()
  return self.input
end

function player:getmousePos()
  return self.mousex, self.mousey
end

function player:getShoot()                                 -- end of get methods
  return self.canshoot
end

function player:getOffset()
  return self.xoffset, self.yoffset
end

function player:setName(text)                              -- start of set methods
  self.name = text
end

function player:setHealth(value)
  self.health = value
end

function player:setmaxHealth(value)
  self.maxhealth = value
end

function player:setGun(weapon)
  self.gun = weapon
end

function player:setLife(bool)
  self.life = bool
end

function player:setState(state)
  self.state = state
end

function player:setX(value)
  self.xposition = value
end

function player:setY(value)
  self.yposition = value
end

function player:setVelocity(value)
  self.velocity = value
end

function player:setInput(bool)
  self.input = bool
end

function player:setShoot(bool)                                  -- end of set methods
  self.canshoot = bool
end

function player:setimg(filepath)
  self.img = love.graphics.newImage(filepath)
end

function player:imgupdate()
  if self:getGun() == M4:getName() then
    self:setimg("assets/player/standingwithgun.png")
  end
end

function player:getimg()
  return self.img
end

function player:getvisionbox()
  local x, y = self:getPos()
  local xo, yo = self:getOffset()
  local w, h = self:getDimensions()
  x = x - 300 - xo
  y = y - 300 - yo
  w = w + 600
  h = h + 600
  return x, y, w, h
end

function player:ammo() -- draws the player ammo to screen depending on which gun the player is using
  if self:getGun() == M4:getName() then

    local pA = M4:getplayerAmmo()
    local pC = M4:getplayerClip()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    local x,y = self:getPos()
    love.graphics.setColor( 255, 255, 255, 255)
    love.graphics.print(pC .. "/" .. pA .. "  " .. M4:getName(), x - width/2 + 3, y + height/2 - 30)

  elseif self:getGun() == M9:getName() then

    local pA = M9:getplayerAmmo()
    local pC = M9:getplayerClip()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    local x,y = self:getPos()
    love.graphics.setColor( 255, 255, 255, 255)
    love.graphics.print(pC .. "/" .. pA .. "  " .. M9:getName(), x - width/2 + 3, y + height/2 - 30)

  elseif self:getGun() == M23:getName() then

    local pA = M23:getplayerAmmo()
    local pC = M23:getplayerClip()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    local x,y = self:getPos()
    love.graphics.setColor( 255, 255, 255, 255)
    love.graphics.print(pC .. "/" .. pA .. "  " .. M23:getName(), x - width/2 + 3, y + height/2 - 30)

  end
end
function player:draw()              -- draw function to draw the player
  local x, y = self:getPos()
  local w, h = self:getDimensions()
  local xoffset, yoffset = self:getOffset()
  local img = player.img
  local angle = M4Bullet:getDirection()
  local vx, vy, vw, vh = self:getvisionbox()
  love.graphics.setColor(255, 255, 255, 255)
  --love.graphics.rectangle("line", vx, vy, vw, vh)
  love.graphics.rectangle("line", x-xoffset, y-xoffset, w, h)
  love.graphics.draw(img, x, y, angle, 1, 1, xoffset, yoffset) -- draw the player with rotation such that it faces towards the mouse

end

function player:move(dt) -- function called in the player update function in the main.lua love.update callback function
  local x, y = self:getPos()
  local v = self:getVelocity()
  local down = love.keyboard.isDown
  if self.input == true then                              -- can only move if the player is allowed to input (can be used for and sort of stuns in the future)
    if down(keybind.up) and self.canwalk.up == true then  -- can only move left if the correct key is pressed and the player is allowed to move in that direction
      local deltaY = y + -(v*dt)                          -- setting the change in the Y position
      self:setY(deltaY)                                   -- setting the new y position
    end

    if down(keybind.down) and self.canwalk.down == true then
      local deltaY = y + v*dt
      self:setY(deltaY)
    end

    if down(keybind.right) and self.canwalk.right == true then
      local deltaX = x + (v*dt)
      self:setX(deltaX)
    end

    if down(keybind.left) and self.canwalk.left == true then
      local deltaX = x + -(v*dt)
      self:setX(deltaX)
    end
  end
end

function player:reload(dt) -- if player pressed the reload button the appropriate gun reloads
  if love.keyboard.isDown(keybind.reload) then
      local gun = player:getGun()
      if gun == M4:getName() then
        M4:playerreload(dt)
      elseif gun == M9:getName() then
        M9:playerreload(dt)
      elseif gun == M23:getName() then
        M23:playerreload(dt)
      end
    end
  end

function player:canShoot() -- checks if player can shoot
  if M4:canplayerShoot() then
    self:setShoot(true)
  else
    self:setShoot(false)
  end
end

function player:camera() -- control the player camera
  local x,y = player:getPos()
  camera:setPosition(x - love.graphics.getWidth() / 2, y - love.graphics.getHeight() / 2) -- set player camera position to top left of screen
end

function player:update(dt)
  self:camera()
  self:imgupdate(dt)
  self:canShoot()
  self:reload(dt)
  self:move(dt)

end

function player:drawhealth() -- draw player health
  local health = math.ceil(self:getHealth())
  local maxhealth = self:getmaxHealth()
  local healthratio = (health*10/maxhealth)/10
  local name = self:getName()
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  local x, y = self:getPos()
  local mx, my = love.mouse.getPosition()
  mx, my = toWorldCoords(mx, my)
  if healthratio <= 0 then
    healthratio = 0
  end

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("Player: " .. name .. "  HP: ".. health, x - width/2 + 5, y - height/2 + 10)

  love.graphics.setColor(50, 50, 50, 255)
  love.graphics.rectangle("fill", x - width/2 + 1, y - height/2 + 38, 204, 14)

  love.graphics.setColor(255*(1-healthratio),200*healthratio, 50, 255)
  love.graphics.rectangle("fill", x - width/2 + 3, y - height/2 + 40, 200*healthratio, 10)

  love.graphics.print("player input:   " .. tostring(globalkey), x - width/2 + 20 , y - height/2 + 60)
end

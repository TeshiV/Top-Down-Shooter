-- health pack file
require "items"

healthpack = items:new{ -- new class from items class
  items = {}
}

function healthpack:setHealth(value)
  self.health = value
end

function healthpack:getHealth()
  return self.health
end


healthpack:setRarity(50)


function healthpack:gen(x, y, size) -- generate healthpack objects
  self:setX(x)
  self:setY(y)
  self:setcanDrop(true)
  
  if size == "large" then
    self:setName("large medkit")
    self:setWidth(25)
    self:setHeight(25)
    local pHealth = player:getmaxHealth()
    local healing = pHealth * 0.5
    self:setHealth(healing)
  elseif size == "medium" then
    self:setName("medium medkit")
    self:setWidth(20)
    self:setHeight(20)
    local pHealth = player:getmaxHealth()
    local healing = pHealth * 0.35
    self:setHealth(healing)
  elseif size == "small" then
    self:setName("small medkit")
    self:setWidth(15)
    self:setHeight(15)
    local pHealth = player:getmaxHealth()
    local healing = pHealth * 0.15
    self:setHealth(healing)
  end
  table.insert(healthpack.items, {
      name = self:getName(),
      x = self:getX(),
      y = self:getY(),
      w = self:getWidth(),
      h = self:getHeight(),
      cDrop = self:getcanDrop(),
      healing = self:getHealth()
      })
end

function healthpack:onCollision(k, p) -- called when player touches a health box
  local pHealth = player:getHealth()
  for k,p in ipairs(self.items) do
    player:setHealth(pHealth + p.healing) -- sets the players health to its health + the healing power of the box
    p.cDrop = false -- cant be dropped anymore
  end
  table.remove(healthpack.items, k) -- remove from the box from the table so it isnt in the game anymore
end

function healthpack:update(dt)
  self:collision()
end

  
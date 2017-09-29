-- ammo file
require "items"

ammo = items:new{
  items = {}
}

function ammo:setAmmo(value)
  self.Ammo = value
end

function ammo:getAmmo()
  return self.Ammo
end


ammo:setRarity(100)


function ammo:gen(x, y, size)
  self:setX(x)
  self:setY(y)
  self:setcanDrop(true)

  if size == "large" then
    self:setName("large Ammo")
    self:setWidth(25)
    self:setHeight(25)
    local ammo = 20
    self:setAmmo(ammo)
  elseif size == "medium" then
    self:setName("medium Ammo")
    self:setWidth(20)
    self:setHeight(20)
    local ammo = 40
    self:setAmmo(ammo)
  elseif size == "small" then
    self:setName("small Ammo")
    self:setWidth(15)
    self:setHeight(15)
    local ammo = 60
    self:setAmmo(ammo)
  end
  table.insert(ammo.items, {
      name = self:getName(),
      x = self:getX(),
      y = self:getY(),
      w = self:getWidth(),
      h = self:getHeight(),
      cDrop = self:getcanDrop(),
      ammo = self:getAmmo()
      })
end

function ammo:onCollision(k, p) -- called when player touches a health box
  local gun = player:getGun()

    local ammo4 = M4:getplayerAmmo()

    local ammo9 = M9:getplayerAmmo()

    local ammo23 = M23:getplayerAmmo()

  for k,p in ipairs(self.items) do
    if gun == "M4" then
      M4:setplayerAmmo(ammo4 + p.ammo) -- sets the players health to its health + the healing power of the box
      p.cDrop = false -- cant be dropped anymore
    elseif gun == "M9" then
      M9:setplayerAmmo(ammo9 + p.ammo)
      p.cDrop = false
    elseif gun == "M23" then
      M23:setplayerAmmo(ammo23 + p.ammo)
      p.cDrop = false
    end
  end
  table.remove(ammo.items, k) -- remove from the box from the table so it isnt in the game anymore
end

function ammo:update(dt)
  self:collision()
end

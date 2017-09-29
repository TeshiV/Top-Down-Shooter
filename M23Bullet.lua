-- sniper bullet file 
require "bullets"

M23Bullet = bullets:new{
  bullets = {}
}

function M23Bullet:gen(speed, damage)
  local x, y = player:getPos()
  local w, h = player:getDimensions()

  self:setID()
  self:setX(x+4)
  self:setY(y)
  self:setWidth(2)
  self:setHeight(2)
  self:setVelocity(speed)
  self:setDamage(damage)

  table.insert(M23Bullet.bullets, {
  id = self:getID(),
  x = self:getX(),
  y = self:getY(),
  w = self:getWidth(),
  h = self:getHeight(),
  dir = self:getDirection(),
  v = self:getVelocity(),
  dmg = self:getDamage()
  })  
end

function M23Bullet:position(dt)
  M23Bullet:setDirection()
  local index, value
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  for index,value in ipairs(self.bullets) do
    
    value.x = value.x + math.cos(value.dir) * value.v*dt
    value.y = value.y + math.sin(value.dir) * value.v*dt
    
    local x,y = player:getPos()
    if (value.x > x + width) or (value.x < x - width) or (value.y > y + height) or (value.y < y - height) then
      table.remove(M23Bullet.bullets, index)
    end
  end
end

function M23Bullet:update(dt)
  self:position(dt)
  self:iswallHit()
end
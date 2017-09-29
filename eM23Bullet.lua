-- enemy bullet file
require "bullets"
eM23Bullet = bullets:new{
  bullets = {}
}

function eM23Bullet:gen(x, y, direction, speed, damage) -- takes x and y positions and speed and damage as arguments for the function
  
  self:setID()
  self:setX(x)
  self:setY(y)
  self:setWidth(2)
  self:setHeight(2)
  self:setVelocity(speed)
  self:setDamage(damage)
  
  table.insert(eM23Bullet.bullets, {
  id = self:getID(),
  x = self:getX(),
  y = self:getY(),
  w = self:getWidth(),
  h = self:getHeight(),
  dir = direction,
  v = self:getVelocity(),
  dmg = self:getDamage()
  })  
end

function eM23Bullet:position(dt)
  local index, value
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  
  for index,value in ipairs(self.bullets) do
    
    value.x = value.x + math.cos(value.dir) * value.v*dt
    value.y = value.y + math.sin(value.dir) * value.v*dt
    
    local x,y = player:getPos()
    if (value.x > x + width) or (value.x < x - width) or (value.y > y + height) or (value.y < y - height) then
      table.remove(eM23Bullet.bullets, index)
    end
  end
end

function eM23Bullet:update(dt)
  self:position(dt)
  self:isplayerHit()
  self:iswallHit()
end
-- pistol bullet file
require "bullets"

M9Bullet = bullets:new{
  bullets = {}
}

function M9Bullet:gen(speed, damage) -- generation function
  local x, y = player:getPos()
  local w, h = player:getDimensions()

  self:setID()
  self:setX(x+4)
  self:setY(y)
  self:setWidth(2)
  self:setHeight(2)
  self:setVelocity(speed)
  self:setDamage(damage)

  table.insert(M9Bullet.bullets, { -- insert date into bullets table
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

function M9Bullet:position(dt) -- update bullet position
  M9Bullet:setDirection()
  local index, value
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  for index,value in ipairs(self.bullets) do
    
    value.x = value.x + math.cos(value.dir) * value.v*dt -- increment x and y towards the mouse at point of generation
    value.y = value.y + math.sin(value.dir) * value.v*dt
    
    local x,y = player:getPos()
    if (value.x > x + width) or (value.x < x - width) or (value.y > y + height) or (value.y < y - height) then
      table.remove(M9Bullet.bullets, index) -- if bullet goes off screen relative to player remove bullet from game to save memory
    end
  end
end

function M9Bullet:update(dt)
  self:position(dt)
  self:iswallHit()
end
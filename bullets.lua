-- bullets file
require "guns"
require "scripts"
bullets = guns:new{ -- bullets class made from gun class
  direction = nil,
  velocity = nil,
  damage = nil}

bullets:setWidth(4)
bullets:setHeight(4)
bullets.bullet = {}

function bullets:setDirection() -- set direction of bullets
  local mx, my = love.mouse.getPosition()
  mx, my = toWorldCoords(mx,my)
  local x, y = player:getPos()
  local xoffset, yoffset = player:getOffset()
  local w, h = player:getDimensions()
  self.direction = math.atan2(my-(y),mx-(x))
    return self.direction
end

function bullets:setenemyDirection(enemy)
  local x, y = player:getPos()
  local xo, yo = player:getOffset()
  local ex, ey
  local exo, eyo
  x = x-xo
  y = y-yo
  if enemy == "grunt" then
    ex, ey = grunt:getPos()
    exo, eyo = grunt:getOffset()
    ex = ex - exo
    ey = ey - eyo
  end
  self.eDirection = math.atan2(y-ey, x-ex)
end

function bullets:getenemyDirection()
  return self.eDirection
end

function bullets:setVelocity(value)
  self.velocity = value
  return self.velocity
end

function bullets:setDamage(value)
  self.damage = value
  return self.damage
end

function bullets:getDirection()
  return self.direction
end

function bullets:getVelocity()
  return self.velocity
end

function bullets:getDamage()
  return self.damage
end

function bullets:reload()
end
function bullets:ammo(dt)
  local clip = self:getplayerClip()
  local ammo = self:getplayerAmmo()
  if clip <= 0 then
    clip = 0
    self:setplayerClip(clip)
  end
end

function bullets:draw()
  local i,v
  for i,v in ipairs(self.bullets) do
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)
  end
end

function bullets:isplayerHit() -- checks if the player is hit
  local x,y = player:getPos()
  local w,h = player:getDimensions()
  local xo,yo = player:getOffset()
  x = x - xo
  y = y - yo
  local health = player:getHealth()
  local i,v
  for i,v in ipairs(self.bullets) do
    if checkCollision(x, y, w, h, v.x, v.y, v.w, v.h) then
      player:setHealth(health - v.dmg) --- decrease player health
      table.remove(self.bullets, i)
      return true
    end
  end
end

function bullets:iswallHit()
  local i,v
  for i,v in ipairs(self.bullets) do
    local k,p
    for k,p in pairs(map.walls) do
      if checkCollision(p.x, p.y, p.w, p.h, v.x, v.y, v.w, v.h) then
        table.remove(self.bullets, i) -- if wall is hit remove bullet so bullet doesnt go through wall
        return true
      end
    end
  end
end
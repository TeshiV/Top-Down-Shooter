-- enemies class file
enemies = entities:new{
  maxhealth = 1000,
  health = 1000,
  stamina = 100,
  velocity = 200,
  life = true,
  candrop = true,
  dropchance = 50
  }

function enemies:getGun()
  return self.gun 
end

function enemies:setGun(value)
  self.gun = value
end

function enemies:getmaxHealth()
  return self.maxhealth
end

function enemies:getHealth()
  return self.health
end

function enemies:getStamina()
  return self.stamina
end

function enemies:getLife()
  return self.life
end

function enemies:getVelocity()
  return self.velocity
end

function enemies:getXO() -- get x offset ( for image )
  return self.xo
end

function enemies:getYO()
  return self.yo
end

function enemies:getOffset()
  return self.xo, self.yo
end

function enemies:canDrop() -- if enemy can drop and item
  if self.candrop then
    return true
  else
    return false
  end
end

function enemies:getcanDrop()
  return self.canDrop
end

function enemies:getdropChance()
  return self.dropchance
end

function enemies:getAngle()
  return self.angle
end

function enemies:angleUpdate() -- if the enemy is alive and has seen the player set the angle towards the player
  local px, py = player:getPos()
  local i,v
  for i,v in ipairs(self.bodies) do
    if v.seen == true and v.life then
      v.angle = math.atan2(py - v.y, px - v.x)
    else
      v.angle = v.angle
    end
  end
end

function enemies:visionUpdate() -- update the box around each enemy in which they can see
  local i,v
  for i,v in ipairs(self.bodies) do
    v.vx = v.x - 300 - v.xo
    v.vy = v.y - 300 - v.yo
    v.vw = v.w + 600
    v.vh = v.h + 600
  end
end

function enemies:setdropChance(value)
  self.dropchance = value
end

function enemies:setmaxHealth(value)
  self.maxhealth = value
  return self.maxhealth
end

function enemies:setHealth(value)
  self.health = value
end

function enemies:setStamina(value)
  self.stamina = value
end

function enemies:setcanDrop(bool)
  self.canDrop = bool
end

function enemies:setVelocity(value)
  self.velocity = value
end

function enemies:setXO(value)
  self.xo = value
end

function enemies:setYO(value)
  self.yo = value
end

function enemies:setLife(bool)
  self.life = bool
end

function enemies:setvisionbox()
  local i,v
  for i,v in ipairs(self.bodies) do
    v.vx = v.x - 300 - v.xo
    v.vy = v.y - 300 - v.yo
    v.vw = v.w + 600
    v.vh = v.h + 600
  end
end

function enemies:getvisionX()
  return self.vx
end

function enemies:getvisionY()
  return self.vy
end

function enemies:getvisionW()
  return self.vw
end

function enemies:getvisionH()
  return self.vh
end

function enemies:setDirection(direction)
  self.direction = direction
end

function enemies:getDirection()
  return self.direction
end

function enemies:hasSeen()
  return self.seen
end

function enemies:setSeen(bool)
  self.seen = bool
end

function enemies:canSee() -- checks if enemy can see the player
  local x, y = player:getPos()
  local xo, yo = player:getOffset()
  local w, h = player:getDimensions()
  local i,v
  for i,v in ipairs(self.bodies) do -- iterate through table of enemies
    local eAngle = math.deg(math.atan2(y-v.y, x-v.x)) -- the angle between the player and the enemy
    if v.life == true then -- if the enemy is alive then
      if v.dir == "east"  then -- if the enemy direction is set to east
        if v.seen == false then -- if the enemy has not already seen the player
          if checkCollision(x-xo, y-yo, w, h, v.vx, v.vy, v.vw, v.vh) and eAngle <= 45 and eAngle >= -45 then -- if the player is in the visionbox and within a specified angle
            v.cSee = true -- the enemy can see the player so the player is within the vision box
            v.seen = true -- the player has been seen
          else
            v.cSee = false -- the enemy is not able to see the player
          end
        end
        if v.seen == true then  -- once the enemy has already been seen the player
          if checkCollision(x, y, w, h, v.vx, v.vy, v.vw, v.vh) then -- if the player is in the vision box
            v.cSee = true -- the enemy can still see
          else 
            v.cSee = false -- the enemy lost vision of the player
          end
        end
      end
      if v.dir == "south" then
        if v.seen == false then
          if checkCollision(x-xo, y-yo, w, h, v.vx, v.vy, v.vw, v.vh) and eAngle <= 135 and eAngle >= 45 then
            v.cSee = true
            v.seen = true
          else
            v.cSee = false
          end
        end
        if v.seen == true then                     
          if checkCollision(x, y, w, h, v.vx, v.vy, v.vw, v.vh) then                      
            v.cSee = true
          else 
            v.cSee = false
          end
        end
      end
      if v.dir == "west" then
        if v.seen == false then
          if checkCollision(x-xo, y-yo, w, h, v.vx, v.vy, v.vw, v.vh) and eAngle <= -135 or eAngle >= 135 then
            v.cSee = true
            v.seen = true
          else
            v.cSee = false
          end
        end
        if v.seen == true then                     
          if checkCollision(x, y, w, h, v.vx, v.vy, v.vw, v.vh) then                      
            v.cSee = true
          else 
            v.cSee = false
          end
        end
      end
      if v.dir == "north" then 
        if v.seen == false then
          if checkCollision(x-xo, y-yo, w, h, v.vx, v.vy, v.vw, v.vh) and eAngle <= -45 and eAngle >= -135 then
            v.cSee = true
            v.seen = true
          else
            v.cSee = false
          end
        end
        if v.seen == true then                     
          if checkCollision(x, y, w, h, v.vx, v.vy, v.vw, v.vh) then                      
            v.cSee = true
          else 
            v.cSee = false
          end
        end
      end
    end
  end
end

function enemies:chase(dt) -- the enemy chase the player while the player isnt in the vision box but has already been seen.
  local x,y = player:getPos()
  local i,v
  for i,v in ipairs(self.bodies) do
    if v.seen == true and v.life and v.cSee == false then -- if the player has been seen and the enemy is still alive but cant see the player anymore then
      local angle = math.atan2(y-v.y, x-v.x)  -- the angle between the player and the enemy
      v.x = v.x + math.cos(angle) * v.v*dt    -- increase the enemy x by adding cos of the angle multiplied by the speed
      v.y = v.y + math.sin(angle) * v.v*dt    -- increase the enemy y by adding sine of the angle multiplied by the speed
      
    end
  end
end

function enemies:draw()
  local angle = eM4Bullet:getenemyDirection()
  local i,v
  for i,v in ipairs(self.bodies) do                                       -- iterate through the table containing the enemy objects
    local life = v.life
    if life == true then                                                         -- if the enemy is alive then draw else dont draw enemy
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.draw(v.img, v.x, v.y, v.angle, 1, 1, v.xo, v.yo)  -- draw enemy
    end

  end
end

function enemies:collision() -- when enemy collides with bullets
  local i,v
  for i,v in ipairs(self.bodies) do
    if player:getGun() == M4:getName() then
      local k,p
      for k,p in ipairs(M4Bullet.bullets) do
        if checkCollision(v.x-v.xo, v.y-v.yo, v.w, v.h, p.x, p.y, p.w, p.h) and v.life then -- if they collide and the enemy is alive
          v.health = v.health - p.dmg -- subtract the bullet damage from enemy life
          self:setHealth(v.health)
          table.remove(M4Bullet.bullets, k) -- remove bullet from screen so it doesnt go through the enemy
          return true
        end
      end
    end
    if player:getGun() == M9:getName() then
      local k,p
      for k,p in ipairs(M9Bullet.bullets) do
        if checkCollision(v.x-v.xo, v.y-v.yo, v.w, v.h, p.x, p.y, p.w, p.h) and v.life then
          v.health = v.health - p.dmg
          self:setHealth(v.health)
          table.remove(M9Bullet.bullets, k)
          return true
        end
      end
    end
    if player:getGun() == M23:getName() then
      local k,p
      for k,p in ipairs(M23Bullet.bullets) do
        if checkCollision(v.x-v.xo, v.y-v.yo, v.w, v.h, p.x, p.y, p.w, p.h) and v.life then
          v.health = v.health - p.dmg
          self:setHealth(v.health)
          table.remove(M23Bullet.bullets, k)
          return true
        end
      end
    end
  end
end

function enemies:update(dt)
  self:collision()
  self:healthupdate(dt)
  self:visionUpdate()
  self:angleUpdate()
  self:canSee()
  self:chase(dt)
end

function enemies:drawhealth()
  local xo, yo = self:getOffset()
  local i,v
  for i,v in ipairs(self.bodies) do
    local health = v.health
    local maxhealth = v.maxhealth
    local healthratio = (health*10/maxhealth)/10
    local name = v.name
    local x = v.x
    local y = v.y
    local life = v.life
    local lifeState = nil
    if healthratio <= 0 then
      healthratio = 0
    end
    
    
    
    if life then
      love.graphics.setColor(255, 0, 0, 255)
      love.graphics.print(name.. "  ".. health, x - xo, y - 30 - yo)
      love.graphics.setColor(50, 50, 50, 255)
      love.graphics.setColor(255*(1-healthratio), 255*healthratio, 0, 255)
      love.graphics.rectangle("fill", x - xo, y - yo - 7, 50*healthratio, 3)
    else
    end
    
    
  end
end

function enemies:healthupdate(dt) -- keep track of enemy health
  local i,v
  for i,v in ipairs(self.bodies) do
    local health = v.health
    local maxhealth = v.maxhealth
    
    if health <= 0 then
      health = 0
      v.health = health
      v.life = false
    end
    
    if health > maxhealth then
      health = maxhealth
      v.health = health 
    end
    local healthchance = healthpack:getRarity() -- get rarity of items
    local ammochance = ammo:getRarity()
    if v.life == false and v.canDrop then
      if randomGen(1, 100, v.dChance) and randomGen(1, 100, healthchance) then -- if chance to drop then drop item
          healthpack:gen((v.x + (v.w/2) - v.xo), (v.y + (v.h/2) - v.yo), "small")
          v.canDrop = false
      else
        v.canDrop = false -- so the enemy cant drop infinitely
      end
      if randomGen(1, 100, v.dChance) and randomGen(1, 100, ammochance) then
        ammo:gen(v.x, v.y, "small")
        v.canDrop = false
      else
        v.canDrop = false
      end
    end         
  end
end
  
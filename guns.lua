-- guns file 
require "grunt"
guns = entities:new()

function guns:setplayermaxAmmo(value)
  self.maxplayerAmmo = value
end

function guns:setplayerAmmo(value)
  self.playerAmmo = value
end

function guns:setplayerClip(value)
  self.playerClip = value
end

function guns:setplayermaxClip(value)
  self.playermaxClip = value
end
function guns:setenemymaxAmmo(value)
  self.enemymaxAmmo = value
end

function guns:setenemyAmmo(value)
  self.enemyAmmo = value
end

function guns:setenemyClip(value)
  self.enemyClip = value
end

function guns:setenemymaxClip(value)
  self.enemymaxClip = value
end

function guns:setreloadDelay(value)
  self.reloadDelay = value
end

function guns:setreloadCD(value)
  self.reloadCD = value
end

function guns:getplayermaxAmmo()
  return self.playermaxAmmo
end

function guns:getplayerAmmo()
  return self.playerAmmo
end

function guns:getplayermaxClip()
  return self.playermaxClip
end

function guns:getplayerClip()
  return self.playerClip
end

function guns:getenemymaxAmmo()
  return self.enemymaxAmmo
end

function guns:getenemyAmmo()
  return self.enemyAmmo
end

function guns:getenemymaxClip()
  return self.enemymaxClip
end

function guns:getenemyClip()
  return self.enemyClip
end

function guns:getreloadDelay()
  return self.reloadDelay
end

function guns:getreloadCD()
  return self.reloadCD
end

function guns:isReload()
  return self.canReload
end

function guns:canplayerShoot() -- check if the player can shoot
  if self:getplayerClip()>=1 and self:getreloadDelay() == 0 and self:getfireCD() == 0 then -- if the player has ammo, not reloading and the cooldown between shots is 0
    return true
  else 
    return false
  end
end

function guns:canenemyShoot() -- check if an enemy can shoot
  local i,v
  for i,v in ipairs(grunt.bodies) do -- iterates for each enemy's weapon and checks these conditions to deterime whether the enemy can shoot
    if v.wep.Clip >= 1 and v.wep.rDelay == 0 and v.wep.fCD == 0 then
      v.wep.cShoot = true
    else
      v.wep.cShoot = false
    end
  end
end

function guns:getfireCD()
  return self.fireCD
end

function guns:setfireCD(value)
  self.fireCD = value
end

function guns:setfirerate(value)
  self.firerate = value
end

function guns:getfirerate()
  return self.firerate
end

function guns:fireCDupdate(dt) -- sets variable to the lower value, 0 or the variable subtract a value ( which when below 0 results in the first parameter being chosen)
  self.fireCD = math.max(0, self.fireCD - dt)
end

function guns:reloadupdate(dt)
  self.reloadDelay = math.max(0, self.reloadDelay - dt)
end

function guns:setReload(bool)
  self.canReload = bool
end

function guns:playerammo(dt) -- keeps track of the ammo in the gun
  local playermaxammo = self:getplayermaxAmmo()
  local playerammo = self:getplayerAmmo()
  local playermaxclip = self:getplayermaxClip()
  local playerclip = self:getplayerClip()
  local reloadAmount = playermaxclip - playerclip
  
  if playerclip < playermaxclip and playerammo > 0 then
    self:setReload(true) -- they player is able to reload
  end
  if playerammo <= 0 then
    self:setplayerAmmo(0)
  end
  
  if playerclip <= 0 then
    playerclip = 0
    self:setplayerClip(playerclip)
    self:playerreload(dt) -- reload if no ammo in clip
  end
  
end

function guns:enemyammo(dt)
  local i,v
  for i,v in ipairs(grunt.bodies) do
    if v.wep.Clip < v.wep.maxClip and v.wep.Ammo > 0 then
      v.wep.cReload = true
    end
    if v.wep.Ammo <= 0 then
      v.wep.Ammo = 0
    end
    
    if v.wep.Clip <= 0 then
      v.wep.Clip =0
      self:enemyreload(dt)
    end
  end
end

function guns:playerreload(dt) -- called when the corresponding keybind is pressed
  local playerammo = self:getplayerAmmo()
  local playermaxclip = self:getplayermaxClip()
  local playerclip = self:getplayerClip()
  local reloadAmount = playermaxclip - playerclip
  local reload = self:isReload()
  
  if reloadAmount > playerammo then
    reloadAmount = playerammo
  end
  
  if reload then
    self:reloadupdate(dt) -- start the reload cooldown where the player cant shoot
    self:setplayerClip(playerclip + reloadAmount)
    self:setplayerAmmo(playerammo - reloadAmount)
    self:setreloadDelay(self:getreloadCD())
  end
  self:setReload(false)
end

function guns:getOwner()
  return self.owner
end

function guns:setOwner(name)
  self.owner = name
end

function guns:enemyreload(dt)
  local i,v
  for i,v in ipairs(grunt.bodies) do
    local reloadAmount = v.wep.maxClip - v.wep.Clip
    local reload = v.wep.cReload
    
    if reloadAmount > v.wep.Ammo then
      reloadAmount = v.wep.Ammo
    end
    v.wep.rDelay = math.max(0, v.wep.rDelay - dt) -- the reload delay is equal to the higher of the 2 arguments, 0 or (v.wep.rDelay - dt)
    if reload and v.wep.Clip == 0 then
      
      v.wep.Clip = v.wep.Clip + reloadAmount
      v.wep.Ammo = v.wep.Ammo - reloadAmount
      v.wep.rDelay = v.wep.rCD -- resets the reload delay to the reload cooldown so the enemy cant shoot until it has reached 0 again
    end
    v.wep.cReload = false
  end
end

function guns:playerShoot(gun, dt) -- check players gun then returns true if all conditions are met
  if gun == "M4" then
    M4:fireCDupdate(dt)
    M4:reloadupdate(dt)
    if M4:canplayerShoot() then
      if love.mouse.isDown(keybind.shoot) and M4:getfireCD() == 0 and M4:getreloadDelay() == 0 then -- shoot if mouse button is held, the firing CD and reload CD is 0 
        return true
      end
    end
  elseif gun == "M9" then
    M9:fireCDupdate(dt)
    M9:reloadupdate(dt)
    if M9:canplayerShoot() then
      if love.mouse.isDown(keybind.shoot) and M9:getfireCD() == 0 and M9:getreloadDelay() == 0 then -- shoot if mouse button is held, the firing CD and reload CD is 0 
        return true
      end
    end
  elseif gun == "M23" then
    M23:fireCDupdate(dt)
    M23:reloadupdate(dt)
    if M23:canplayerShoot() then
      if love.mouse.isDown(keybind.shoot) and M23:getfireCD() == 0 and M23:getreloadDelay() == 0 then -- shoot if mouse button is held, the firing CD and reload CD is 0 
        return true
      end
    end
  end
end

function guns:playerfire(dt)
  local M4maxplayerRifleAmmo = M4:getplayermaxAmmo() -- localise all ammo for different weapons
  local M4playerRifleAmmo = M4:getplayerAmmo()
  local M4playerClip = M4:getplayerClip()
  local M4playermaxClip = M4:getplayermaxClip()
  
  local M9maxplayerRifleAmmo = M9:getplayermaxAmmo()
  local M9playerRifleAmmo = M9:getplayerAmmo()
  local M9playerClip = M9:getplayerClip()
  local M9playermaxClip = M9:getplayermaxClip()
  
  local M23maxplayerRifleAmmo = M23:getplayermaxAmmo()
  local M23playerRifleAmmo = M23:getplayerAmmo()
  local M23playerClip = M23:getplayerClip()
  local M23playermaxClip = M23:getplayermaxClip()
  local gun = player:getGun()
  if M23:playerShoot(gun, dt) then
    
    if gun == M4:getName() then -- depending on weapon selected and whether the player has initiated the firing sequeunce, generate the appropriate bullet
      
      M4:setfireCD(M4:getfirerate())
      M4Bullet:gen(2000, 50)
      M4playerClip = M4playerClip - 1
      M4:setplayerClip(M4playerClip)
      
    elseif gun == M9:getName() then
      
      M9:setfireCD(M9:getfirerate())
      M9Bullet:gen(2000, 90)
      M9playerClip = M9playerClip - 1
      M9:setplayerClip(M9playerClip)
      
    elseif gun == M23:getName() then
      
      M23:setfireCD(M23:getfirerate())
      M23Bullet:gen(2000, 180)
      M23playerClip = M23playerClip - 1
      M23:setplayerClip(M23playerClip)
      
    end
  end
end

function guns:enemyfire(dt)
    local i,v
    for i,v in ipairs(grunt.bodies) do
      v.wep.fCD = math.max(0, v.wep.fCD - dt)
      if v.wep.cShoot and v.cSee and v.life then
        v.wep.fCD = v.wep.fRate
        eM4Bullet:gen(v.x, v.y, v.angle, 2000, 20) -- generated a bullet for each enemy x and y where they can shoot and can see the player 
        v.wep.Clip = v.wep.Clip - 1
        print(v.wep.Clip)
      end
    end
  end

function guns:playerupdate(dt)
  self:playerfire(dt)
  self:playerammo(dt)
end

function guns:enemyupdate(dt)
  self:enemyfire(dt)
  self:enemyammo(dt)
  self:canenemyShoot(dt)
  self:enemyreload(dt)
end


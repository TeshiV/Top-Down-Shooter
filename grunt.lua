-- grunt file
grunt = enemies:new{ -- class from enenmies
  bodies = {}
  }

function grunt:setImg(filepath)
  self.img = love.graphics.newImage(filepath)
end

function grunt:getimg()
  return self.img 
end

function grunt:gen(x, y, name, direction) -- gen function
  self:setX(x)
  self:setY(y)
  self:setName(name)
  self:setVelocity(100)
  self:setWidth(32)
  self:setHeight(32)
  self:setmaxHealth(500)
  if name == "grunt" then
    self:setHealth(500)
  elseif name == "tank" then
    self:setHealth(1000)
  end

  self:setLife(true)
  self:setcanDrop(true)
  self:setdropChance(100)
  self:setImg("assets/enemy/standingwithgun.png")
  self:setGun(eM4:getName())
  self:setYO(17)
  self:setXO(11)
  self:setDirection(direction)
  self:setSeen(false)
  if direction == "east" then -- based off direction set an initial angle for the grunt to see in
    angle = math.rad(0) 
  elseif direction == "south" then
    angle = math.rad(90)
  elseif direction == "west" then
    angle = math.rad(180)
  elseif direction == "north" then
    angle = math.rad(-90)
  end
  
  table.insert(self.bodies, {
    x = self:getX(),
    y = self:getY(),
    w = self:getWidth(),
    h = self:getHeight(),
    name = self:getName(),
    v = self:getVelocity(),
    health = self:getHealth(),
    maxhealth = self:getmaxHealth(),
    life = self:getLife(),
    dChance = self:getdropChance(),
    canDrop = self:getcanDrop(),
    img = self:getimg(),
    xo = self:getXO(),
    yo = self:getYO(),
    dir = self:getDirection(),
    seen = self:hasSeen(),
    cSee = nil,
    vx = nil,
    vy = nil,
    vw = nil,
    vh = nil,
    angle = angle,
    wep = {
      name = eM4:getName(),
      maxAmmo = eM4:getenemymaxAmmo(),
      Ammo = eM4:getenemyAmmo(),
      maxClip = eM4:getenemymaxClip(),
      Clip = eM4:getenemyClip(),
      rDelay = eM4:getreloadDelay(),
      rCD = eM4:getreloadCD(),
      cReload = eM4:isReload(),
      fCD = eM4:getfireCD(),
      fRate = eM4:getfirerate(),
      cShoot = true
      }})
end


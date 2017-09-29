return function ()
  function load()
    require "player"
    require "controls"
    require "entities"
    require "items"
    require "enemies"
    require "grunt"
    require "bullets"
    require "guns"
    require "scripts"
    require "M4"
    require "M9"
    require "M23"
    require "eM4"
    require "M4Bullet"
    require "M9Bullet"
    require "M23Bullet"
    require "eM4Bullet"
    require "scene"
    require "healthpacks"
    require "camera"
    require "states/Level2/map"
    require "ammopack"
    require "heavy"

    player:setX(150)
    player:setY(-3900)
    grunt:gen(200, 700, "Test", "north")

    for i,v in ipairs(grunt.bodies) do -- make sure that any health value for the enemy is reset
      if v.health ~= v.maxhealth then
        v.health = v.maxhealth
      end
    end
  end

  function love.draw()
    camera:set()
    love.graphics.scale(1)
    M4Bullet:draw()
    M9Bullet:draw()
    M23Bullet:draw()
    eM4Bullet:draw()
    game:draw()
    map:draw()
    camera:unset()
  end

  function love.update(dt)
    player:update(dt)
    map:update(dt)
    M9:playerupdate(dt)
    M23:playerupdate(dt)
    M4:playerupdate(dt)
    M4Bullet:update(dt)
    M9Bullet:update(dt)
    M23Bullet:update(dt)
    grunt:update(dt)
    heavy:update(dt)
    eM4:enemyupdate(dt)
    eM4Bullet:update(dt)
    healthpack:update(dt)
    ammo:update(dt)
  end

  function love.keypressed(key)

    if keybind:getkey(key) ~= true then
      print(key .. ": is an invalid input")
      player:setInput(false)
    else
      player:setInput(true)
    end

    if key == "escape" then
      loadState("menu")
    end
    if key == keybind.rifle then
      player:setGun(M4:getName())
    end
    if key == keybind.pistol then
      print("test")
      player:setGun(M9:getName())
    end
    if key == keybind.sniper then
      player:setGun(M23:getName())
    end
    globalkey = key
  end

end

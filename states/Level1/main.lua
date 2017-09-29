--level 1 file
return function ()
  function load() -- one time load function when game is run
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
    require "states/Level1/map"
    require "ammopack"
    require "heavy"

    player:setX(130)
    player:setY(700)

    for i,v in ipairs(grunt.bodies) do
      table.remove(grunt.bodies, i)
    end

    -- require files and generate enemies
    grunt:gen(340, 400, "Basic Enemy", "west")

    love.keyboard.setKeyRepeat(false)
    love.graphics.setBackgroundColor(0, 0, 0, 255)
  end

  function love.draw(dt) -- function called to draw to screen every frame (delta time - time between frames)
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

  function love.update(dt) -- function used to keep track of the state of the game called every frame
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

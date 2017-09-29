-- options screen file
return function ()
  function load()
    require "scripts"
    require "controls"
    font = love.graphics.newFont(20) -- increasing font size 
    love.graphics.setFont(font)
    changekey = love.graphics.newImage("assets/changekey.png") -- more image initialisation
    changekeyOn = love.graphics.newImage("assets/changekey_on.png")
    local Off = changekey -- local variables for use in table below
    local On = changekeyOn
    local bW = 256
    local bH = 64
    
    upchange = false  -- boolean to check which key is being changed
    downchange = false
    leftchange = false
    rightchange = false
    reloadchange = false
    riflechange = false
    pistolchange = false
    sniperchange = false
    
    buttons = -- buttons table
    {
      changeUP =
      {
        off = Off, on = On, x = 1100, y = 100, w = bW, h = bH, action = "changeup"
      },
      changeDown =
      {
        off = Off, on = On, x = 1100, y = 180, w = bW, h = bH, action = "changedown"
      },
      changeLeft =
      {
        off = Off, on = On, x = 1100, y = 260, w = bW, h = bH, action = "changeleft"
      },
      changeRight =
      {
        off = Off, on = On, x = 1100, y = 340, w = bW, h = bH, action = "changeright"
      },
      changeReload =
      {
        off = Off, on = On, x = 1100, y = 420, w = bW, h = bH, action = "changereload"
      },
      changeRifle =
      {
        off = Off, on = On, x = 1100, y = 500, w = bW, h = bH, action = "changerifle"
      },
      changePistol =
      {
        off = Off, on = On, x = 1100, y = 580, w = bW, h = bH, action = "changepistol"
      },
      changeSniper =
      {
        off = Off, on = On, x = 1100, y = 660, w = bW, h = bH, action = "changesniper"
      }
    }
    
  end
  
  local function drawButton(off, on, x, y, w, h, mx, my)
	local ins = insideBox( mx, my, x - (w/2), y - (h/2), w, h ) -- checks if mouse is inside the button
	
	love.graphics.setColor( 255, 255, 255, 255 )
	
	if ins then
		love.graphics.draw( on, x, y, 0, 1, 1, (w/2), (h/2) ) -- draws an image depending if mouse is in the button
	else
		love.graphics.draw( off, x, y, 0, 1, 1, (w/2), (h/2) )
	end
end
  
  function love.draw()
  local k = keybind
  local mx = love.mouse.getX()
  local my = love.mouse.getY()
  
    love.graphics.setColor(255, 255, 255, 255)
    -- if a keybind is being changed it prompts the player which key is being changed and how to change it
    if upchange then 
      love.graphics.print("press key to change up key", 500, 50)
      
    elseif downchange then
      love.graphics.print("press key to change down key", 500, 50)
      
    elseif leftchange then
      love.graphics.print("press key to change left key", 500, 50)
      
    elseif rightchange then
      love.graphics.print("press key to change right key", 500, 50)
      
    elseif reloadchange then
      love.graphics.print("press key to change reload key", 500, 50)
      
    elseif riflechange then
      love.graphics.print("press key to change rifle key", 500, 50)
      
    elseif pistolchange then
      love.graphics.print("press key to change pistol key", 500, 50)
      
    elseif sniperchange then
      love.graphics.print("press key to change sniper key", 500, 50)
      
    end
    -- prints on screen which keys there are and the bindings
    love.graphics.print("Up Key:                                                                                             " .. k.up, 200, 100)
    love.graphics.print("Down Key:                                                                                        " .. k.down, 200, 180)
    love.graphics.print("Left Key:                                                                                            " .. k.left, 200, 260)
    love.graphics.print("Right Key:                                                                                         " .. k.right, 200, 340)
    love.graphics.print("Reload Key:                                                                                       " .. k.reload, 200, 420)
    love.graphics.print("Switch to Rifle:                                                                                 " .. k.rifle, 200, 500)
    love.graphics.print("Switch to Pistol:                                                                                " .. k.pistol, 200, 580)
    love.graphics.print("Switch to Sniper:                                                                              " .. k.sniper, 200, 660)
    
    for i,v in pairs(buttons) do -- iterate through buttons table and draw them
      drawButton(v.off, v.on, v.x, v.y, v.w, v.h, mx, my)
    end
  end
  
  function love.update()
  end
  
  function love.keypressed(key)
    if key == "escape" then -- if escape is pressed, go back to menu
      loadState("menu")
    end
    local v = keybind
    if upchange then -- change keybind to key pressed
      v.up = key
      upchange = false
      
    elseif downchange then
      v.down = key
      downchange = false
      
    elseif leftchange then
      v.left = key
      leftchange = false
      
    elseif rightchange then
      v.right = key
      rightchange = false
      
    elseif reloadchange then
      v.reload = key
      reloadchange = false
      
    elseif riflechange then
      v.rifle = key
      riflechange = false
      
    elseif pistolchange then
      v.pistol = key
      pistolchange = false
      
    elseif sniperchange then
      v.sniper = key
      sniperchange = false
      
    end
  end
  
  function love.mousepressed( x, y, button ) -- if a button is clicked, start change key bind process depending on the button
    if button == 1 then
      for k, v in pairs(buttons) do
        local ins = insideBox( x, y, v.x - (v.w/2), v.y - (v.h/2), v.w, v.h )
        
        if ins then
          if v.action == "changeup" then
            upchange = true
            
          elseif v.action == "changedown" then
            downchange = true
            
          elseif v.action == "changeleft" then
            leftchange = true
            
          elseif v.action == "changeright" then
            rightchange = true
            
          elseif v.action == "changereload" then
            reloadchange = true
            
          elseif v.action == "changerifle" then
            riflechange = true
            
          elseif v.action == "changepistol" then
            pistolchange = true
            
          elseif v.action == "changesniper" then
            sniperchange = true
            
          end
        end
      end
    end
  end

end

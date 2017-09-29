-- main menu screen file
return function ()
  function load()
    love.graphics.clear()
    require "scripts"
    love.graphics.setBackgroundColor(0, 0, 0, 255 )
    
    titlecard = love.graphics.newImage("assets/titlecard.png") -- draw more images
    play = love.graphics.newImage("assets/play.png")
    playOn = love.graphics.newImage("assets/play_on.png")
    exit = love.graphics.newImage("assets/exit.png")
    exitOn = love.graphics.newImage("assets/exit_on.png")
    options = love.graphics.newImage("assets/options.png")
    optionsOn = love.graphics.newImage("assets/options_on.png")
    help = love.graphics.newImage("assets/help.png")
    helpOn = love.graphics.newImage("assets/help_on.png")
    
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    buttons = -- buttons table
    {
      play = 
      { 
        on = playOn, 
        off = play, 
        x = width/2, 
        y = height/2 - 64, 
        w = 256, 
        h = 64,
        action = "play"
      },
      exit = 
      { 
        on = exitOn, 
        off = exit, 
        x = width/2, 
        y = height/2 + 256+64, 
        w = 256, 
        h = 64,
        action = "exit"
      },
      options =
      {
        on = optionsOn,
        off = options,
        x = width/2,
        y = height/2 + 64,
        w = 256,
        h = 64,
        action = "options"
      },
      help =
      {
        on = helpOn,
        off = help,
        x = width/2,
        y = height/2 + 192,
        w = 256,
        h = 64,
        action = "help"
      }
    }
  end

  local function drawButton(off, on, x, y, w, h, mx, my)
    local ins = insideBox( mx, my, x - (w/2), y - (h/2), w, h )
    
    love.graphics.setColor( 255, 255, 255, 255 )
    
    if ins then
      love.graphics.draw( on, x, y, 0, 1, 1, (w/2), (h/2) )
    else
      love.graphics.draw( off, x, y, 0, 1, 1, (w/2), (h/2) )
    end
  end

  function love.draw()
    local x = love.mouse.getX( )
    local y = love.mouse.getY( )
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    love.graphics.draw(titlecard, width/2, height/2 - 256, 0, 1, 1, 1024/2, 128/2)
    for i, v in pairs(buttons) do
      drawButton( v.off, v.on, v.x, v.y, v.w, v.h, x, y )
    end
  end

  function love.update(dt)
  end

  function love.mousepressed( x, y, button )
    if button == 1 then
      for k, v in pairs(buttons) do
        local ins = insideBox( x, y, v.x - (v.w/2), v.y - (v.h/2), v.w, v.h )
        
        if ins then
          if v.action == "play" then -- depending on button clicked, load state
            loadState("Level1")
          elseif v.action == "exit" then
            love.event.quit()
          elseif v.action == "options" then
            loadState("options")
          elseif v.action == "help" then
            loadState("help")
          end
        end
      end
    end
  end

  function love.keypressed(key)
    if key == "escape" then -- go back to title screen 
      loadState("titlescreen")
    end
  end
end
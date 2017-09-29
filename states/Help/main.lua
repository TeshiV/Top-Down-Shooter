--help menu file
return function ()
  function load()
    nextpage = love.graphics.newImage("assets/nextpage.png")
    nextpageOn = love.graphics.newImage("assets/nextpage_on.png")
    previouspage = love.graphics.newImage("assets/previouspage.png")
    previouspageOn = love.graphics.newImage("assets/previouspage_on.png")
    help1 = love.graphics.newImage("assets/htp1.png") -- load button and help images
    help2 = love.graphics.newImage("assets/htp2.png")
    help3 = love.graphics.newImage("assets/htp3.png")
    help4 = love.graphics.newImage("assets/htp4.png")
    help5 = love.graphics.newImage("assets/htp5.png")
    
    page = 1 -- page counter
    
    buttons =
    {
      nextpage = 
      {
        on = nextpageOn, off = nextpage, x = 1280 - 300, y = 720 - 80, w = 256, h = 64, action = "next"
      },
      prevpage =
      {
        on = previouspageOn, off = previouspage, x = 44, y = 720 - 80, w = 256, h = 64, action = "prev"
      }
    }
  end
  
  local function drawButton(off, on, x, y, w, h, mx, my)
	local ins = insideBox( mx, my, x , y , w, h )
	
	love.graphics.setColor( 255, 255, 255, 255 )
	
	if ins then
		love.graphics.draw( on, x, y, 0, 1, 1 )
	else
		love.graphics.draw( off, x, y, 0, 1, 1 )
	end
end
  
  function love.draw()
    local mx = love.mouse.getX()
    local my = love.mouse.getY()
    
    if page == 1 then -- draw help image depending on page number
      love.graphics.draw(help1, 0, 0)
    elseif page == 2 then
      love.graphics.draw(help2, 0, 0)
    elseif page == 3 then
      love.graphics.draw(help3, 0, 0)
    elseif page == 4 then
      love.graphics.draw(help4, 0, 0)
    elseif page == 5 then
      love.graphics.draw(help5, 0, 0)
    end
    for i,v in pairs(buttons) do
      drawButton(v.off, v.on, v.x, v.y, v.w, v.h, mx, my)
    end
    love.graphics.print(page.. "/5", 2, 25) -- draw current page number on top left
  end
  
  function love.update(dt)
    if page > 5 then
      page = 1
    elseif page < 1 then
      page = 5
    end
  end
  
  function love.mousepressed( x, y, button )
    if button == 1 then
      for k, v in pairs(buttons) do
        local ins = insideBox( x, y, v.x, v.y , v.w, v.h )
        
        if ins then
          if v.action == "next" then -- increment or decrement page pointer depending on button pressed
            page = page + 1
          elseif v.action == "prev" then
            page = page - 1
          end
        end
      end
    end
  end

  function love.keypressed(key)
    if key == "escape" then
      loadState("menu")
    end
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end

-- items file
items = entities:new() -- new class made from entities class

function items:setRarity(value)
  self.rarity = value
end

function items:setcanDrop(bool)
  self.canDrop = bool
end

function items:getRarity()
  return self.rarity
end

function items:getcanDrop()
  return self.canDrop
end


function items:draw(r, g, b) --draw items with variable colours
  local i,v
  for i,v in ipairs(self.items) do
    love.graphics.setColor(r, g, b, 255)
    love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)
  end
end

function items:collision() -- check if player collides with item
  local x, y = player:getPos()
  local w, h = player:getDimensions()
  local xoffset, yoffset = player:getOffset()
  local i,v
  for i,v in ipairs(self.items) do
    if checkCollision(x-xoffset, y-xoffset, w, h, v.x, v.y, v.w, v.h) then
      self:onCollision(i, v) -- perform item specific action on collision
    end
  end
end

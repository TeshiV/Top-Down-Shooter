-- entities class file
entities = {
  name = "",
  id = 0,
  xposition = nil,
  yposition = nil,
  width = nil,
  height = nil
}

function entities:new(o) -- function to create classes to inherit entities functions
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function entities:getName()
  return self.name 
end

function entities:getPos()
  return self.xposition, self.yposition
end

function entities:getX()
  return self.xposition
end

function entities:getY()
  return self.yposition
end

function entities:getDimensions()
  return self.width, self.height
end

function entities:getWidth()
  return self.width
end

function entities:getHeight()
  return self.height
end

function entities:setName(name)
  self.name = name
  return self.name
end

function entities:setWidth(width)
  self.width = width
  return self.width
end

function entities:setHeight(height)
  self.height = height
  return self.height
end

function entities:setX(value)
  self.xposition = value
  return self.xposition
end

function entities:setY(value)
  self.yposition = value
  return self.yposition
end

function entities:getID()
  return self.id
end

function entities:setID()
  local count = count or 0
  self.id = count
  count = count + 1
  return self.id
end

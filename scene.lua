-- scene file
require "player"
require "enemies"

scene = {}

function scene:new(o) -- scene class method
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

game = scene:new() -- new scene class called "game"

function game:playerdraw() -- draw player relating things
  player:draw()
  player:drawhealth()
  player:ammo()
end

function game:itemDraw() -- draw item related things
  healthpack:draw(20, 99, 53)
  ammo:draw(30, 30, 30, 53)
end

function game:enemydraw() -- draw enemy related things
  grunt:draw()
  grunt:drawhealth()
  heavy:draw()
  heavy:drawhealth()
end

function game:draw() -- draw game
  self:enemydraw()
  self:itemDraw()
  self:playerdraw()
end
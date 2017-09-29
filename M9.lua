-- pistol gun file
require "guns"
M9 = guns:new()

M9:setName("M9")
M9:setplayermaxAmmo(60)
M9:setplayerAmmo(60)
M9:setplayermaxClip(10)
M9:setplayerClip(10)
M9:setreloadDelay(3)
M9:setreloadCD(3)
M9:setReload(true)
M9:setfireCD(1.5)
M9:setfirerate(1.5)

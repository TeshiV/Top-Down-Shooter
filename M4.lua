--rifle gun file
require "guns"
M4 = guns:new()

M4:setName("M4")
M4:setplayermaxAmmo(240)
M4:setplayerAmmo(240)
M4:setplayermaxClip(30)
M4:setplayerClip(30)
M4:setreloadDelay(3)
M4:setreloadCD(3)
M4:setReload(true)
M4:setfireCD(0.15)
M4:setfirerate(0.15)


-- enemy weapon file
require "guns"
eM4 = guns:new()


eM4:setName("M4")
eM4:setenemymaxAmmo(1000)
eM4:setenemyAmmo(1000)
eM4:setenemymaxClip(5)
eM4:setenemyClip(5)
eM4:setreloadDelay(0.5)
eM4:setreloadCD(0.5)
eM4:setReload(true)
eM4:setfireCD(0.05)
eM4:setfirerate(0.2)
eM4:setOwner(owner)


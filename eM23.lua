-- enemy sniper weapon file
require "guns"
eM23 = guns:new()


eM23:setName("M23")
eM23:setenemymaxAmmo(1000)
eM23:setenemyAmmo(1000)
eM23:setenemymaxClip(5)
eM23:setenemyClip(5)
eM23:setreloadDelay(1)
eM23:setreloadCD(1)
eM23:setReload(true)
eM23:setfireCD(1)
eM23:setfirerate(1)
eM23:setOwner(owner)

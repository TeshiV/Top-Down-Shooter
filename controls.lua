-- controls file
keybind = { -- default control table
  up = "w",
  down = "s",
  right = "d",
  left = "a",
  reload = "r",
  quit = "escape",
  rifle = "1",
  pistol = "2",
  sniper = "3",
  shoot = 1
}

function keybind:getkey(keybinding)  -- function checks the keybind pressed is valid
  if keybinding == keybind.up then
    return true
  end
  
   if keybinding == keybind.down then
    return true
   end
   
   if keybinding == keybind.right then
    return true
   end
   
   if keybinding == keybind.left then
    return true
   end
   
   if keybinding == keybind.quit then
    return true
   end
   
   if keybinding == keybind.shoot then
     return true
   end
   
   if keybinding == keybind.reload then
     return true
   end
   
   if keybinding == keybind.rifle then
     return true
   end
   if keybinding == keybind.pistol then
     return true
   end
   if keybinding == keybind.sniper then
     return true
   end
   
   return false
end
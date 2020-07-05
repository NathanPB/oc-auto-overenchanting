--[[
Copyright (C) 2020 Nathan P. Bombana

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.
--]]

local args = {...}
local robot = require("robot")
local component = require("component")
local sides = require("sides")
local redstone = component.redstone
local nanomachine = require("nanomachine")
local exp = require("exp")
local invctrl = component.inventory_controller
local config = require("config")


function hasEssence()
  return redstone.getInput(config.ESSENCE_SIDE) >= 6
end

function getEnchanterStack()
    return invctrl.getStackInSlot(config.ENCHANTER_SIDE, 1)
end

function getEnchantmentsHash(stack)
  local enchantments = stack.enchantments
  local sum = 0
  for i=1, #enchantments do
    sum = sum + enchantments[i].level
  end
  return sum
end

function enchant()
  local initialStack = getEnchanterStack()
  local lastEnchantment = getEnchantmentsHash(initialStack)
  if hasEssence() then
    exp.supplyIfNeeded()
    robot.use(config.ENCHANTER_SIDE, true)
    
    for i=1, 35 do
      os.sleep(1)
      local stack = getEnchanterStack()
      
      -- If the stack item changed in the middle of the process, restart the enchantment
      if stack.name ~= initialStack.name then
          print("Stack item changed during the ritual. Restarting the enchantment session...")
          return enchant()
      end
      
      local enchantments = getEnchantmentsHash(stack)
      
      if enchantments ~= lastEnchantment then
          return true
      end
    end
  else
    print("Not enough essence")
    os.exit(1)
  end
  
  -- If the enchanter timed out without enchantment changes, so the enchantment is considered a failure. Just like the life of people browsing auto enchantment scripts online, and the life of the people developing it
  return false
end

nanomachine.init()
if args[1] == "forever" then
  repeat until not enchant()
  print("Stopping because the enchantments didn't changed in the last session")
else
  if enchant() then
    print("Enchanted successfully. Enchantments did changed")
  else
    print("The enchantments did not changed this round")
  end
end

--[[
Copyright (C) 2020 Nathan P. Bombana

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.
--]]

local component = require("component")
local redstone = component.redstone
local nano = require("nanomachine")
local config = require("config")

local function startSupply()
  redstone.setOutput(config.EXP_OUT_SIDE, 15)
end

local function stopSupply()
  redstone.setOutput(config.EXP_OUT_SIDE, 0)
end

local function hasEnough()
  local exp = nano.getExperienceLevel()
  if exp == nil then
     stopSupply()
     print("Lost connection with the nanomachine. Aborting...")
     os.exit(1)
  else   
    return exp >= 30
  end
end

local function supplyIfNeeded()
  startSupply()
  repeat until hasEnough()
  stopSupply()
end

return {
  ["supplyIfNeeded"] = supplyIfNeeded
}

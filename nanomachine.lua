--[[
Copyright (C) 2020 Nathan P. Bombana

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.
--]]

local component = require("component")
local modem = component.modem
local event = require("event")
local port = 1111

local function init()
  modem.open(1)
  modem.open(port)
  modem.broadcast(1, "nanomachines", "setResponsePort", port)
  event.pull(6, "modem_message")
end

local function getExperienceLevel()
  modem.broadcast(port, "nanomachines", "getExperience")   
  response = { event.pull(6, "modem_message") }
  return response[8]
end

return { 
  ["init"] = init, 
  ["getExperienceLevel"] = getExperienceLevel
}

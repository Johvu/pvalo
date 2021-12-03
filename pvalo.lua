ESX = nil
local lighton = false
local state = false
local PlayerData        = {}

-- Tehny Johvu

-- PRO CONFIG

local interval = 100
local extra = 9
local button = 157 -- https://docs.fivem.net/docs/game-references/controls/

--- ja sen loppu

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        -- mitä nappia painettu 
        if IsControlJustReleased(0, button) then
            -- työ check
            if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'krp' then
                if not lighton then
					if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
                    exports['mythic_notify']:SendAlert('success', 'Pysätysvalo päällä')

                    lighton = true
					end
                else
					if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
						state = false
						lighton = false
                    exports['mythic_notify']:SendAlert('error', 'Pysätysvalo pois päältä')
					end
                end
			else
				Wait(500)
            end
        end
    end
end)

Citizen.CreateThread(function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    while true do
      Wait(1)
      if lighton then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
            if state then
				state = false
                SetVehicleExtra(vehicle, extra, false)
            else
				state = true
                SetVehicleExtra(vehicle, extra, true)
                SetVehicleAutoRepairDisabled(vehicle, true)
            end
            Wait(interval)
        else
            lighton = false
            Wait(500)
        end
    else
		if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
			if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'krp' then
			SetVehicleExtra(vehicle, extra, true)
			SetVehicleAutoRepairDisabled(vehicle, true)
			state = false
			Wait(100)
			end
		end
        Wait(2500)
     end
    end
end)

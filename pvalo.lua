ESX = nil
local lighton = false
local PlayerData        = {}
local hasperms = false

-- Tehny Johvu

-- PRO CONFIG

local interval = 500 -- speed of the light
local extra = 9 -- extra int usally 1-9
local enableESX = true -- enables job check
local button = 157 -- https://docs.fivem.net/docs/game-references/controls/


--- ja sen loppu

Citizen.CreateThread(function()
    if enableESX then
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        -- mitä nappia painettu 
        if IsControlJustReleased(0, button) then
            -- työ check

            if enableESX then
                if PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'krp' then
                    hasperms = true
                else
                    hasperms = false
                end
            else
                hasperms = true
            end

            if hasperms then
                if not lighton then
					if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
                    exports['mythic_notify']:SendAlert('success', 'Pysätysvalo päällä')
		    --ESX.ShowNotification('Pysätysvalo päällä')

                    lighton = true
					end
                else
					if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
						lighton = false
                    exports['mythic_notify']:SendAlert('error', 'Pysätysvalo pois päältä')
		   		   -- ESX.ShowNotification('Pysätysvalo pois päältä')

					end
                end
			else
				Wait(500)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
      if lighton then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
            if not IsVehicleExtraTurnedOn(vehicle, extra) then
                SetVehicleExtra(vehicle, extra, false)
            else
                SetVehicleExtra(vehicle, extra, true)
                SetVehicleAutoRepairDisabled(vehicle, true)
            end
            Wait(interval)
        else
            lighton = false
            Wait(500)
        end
    else
		if IsVehicleExtraTurnedOn(vehicle, extra) then
			SetVehicleExtra(vehicle, extra, true)
			SetVehicleAutoRepairDisabled(vehicle, true)
		end
        Wait(2500)
     end
    end
end)

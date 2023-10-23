local QBCore = exports['qb-core']:GetCoreObject()

local SpawnedPeds = false
local CreatedPeds = {}


--spawn Config.Peds
CreateThread(function()
    if SpawnedPeds then 
        return 
    end

    
    for k, v in pairs(Config.Peds) do
        if not CreatedPeds[k] then 
            CreatedPeds[k] = {} 
        end
        
        
 
        local model = v["model"][math.random(1, #v["model"])]
        model = type(model) == 'string' and joaat(model) or model
        RequestModel(model)
        
        while not HasModelLoaded(model) do
            Wait(0)
        end
        
        local coords = v["coords"][math.random(1, #v["coords"]]
        
        CreatedPeds[k] = CreatePed(0, model, coords.x, coords.y, coords.z-1, coords.w, false, false) -- spawn ped and insert into CreatedPeds{} table
                
        if v["freeze"] then
            FreezeEntityPosition(CreatedPeds[k], true)
        else
            SetPedAllowedToDuck(CreatedPeds[k], true) -- can duck
        end
                
        SetPedCanLosePropsOnDamage(CreatedPeds[k], false, 0) -- will not lose helmet or glasses
                
        if v["relationship"] then
            SetPedRelationshipGroupHash(CreatedPeds[k], GetHashKey(v["relationship"]))
        end

        if v["playerdmg"] then
            SetEntityOnlyDamagedByRelationshipGroup(CreatedPeds[k], true, 0x6F0783F5) -- can only be damaged by player
        end
        
        if v["hostile"] then
            SetPedAsEnemy(CreatedPeds[k], true) -- hostile
            SetPedRelationshipGroupHash(CreatedPeds[k], 0x84DCFAAD) -- auto shoots players
            SetPedCombatAttributes(CreatedPeds[k], 46, true) -- always fight
            SetPedConfigFlag(CreatedPeds[k], 128, true) -- can be agitated
        end
        
        if v["ragdoll"] and not v["freeze"] then
            SetPedCanRagdoll(CreatedPeds[k], false)-- never ragdoll 
            SetPedCanRagdollFromPlayerImpact(CreatedPeds[k], false) -- cannot ragdoll on player impact
        end
                

        -- combat --
        SetPedCombatMovement(CreatedPeds[k], v["movement"])
        SetPedCombatRange(CreatedPeds[k], v["range"]) -- combat range
       
        if v["alwaysfight"] == 1 then 
            SetPedCombatAttributes(CreatedPeds[k], 5, false) -- fight without weapons
            SetPedCombatAttributes(CreatedPeds[k], 0, false) -- can use cover
            SetPedCanCowerInCover(CreatedPeds[k], true) 
            SetPedCanPeekInCover(CreatedPeds[k], true) -- can peek in cover 
        elseif v["alwaysfight"] == 0 then 
            SetPedCombatAttributes(CreatedPeds[k], 5, true) 
            SetPedFleeAttributes(CreatedPeds[k], 0, 0) -- never flee
            SetPedCombatAttributes(CreatedPeds[k], 0, false) 
            SetPedCanCowerInCover(CreatedPeds[k], true) -- will hit cover instead of running from gunshot
            SetPedCanPeekInCover(CreatedPeds[k], true) 
        else 
            SetPedCombatAttributes(CreatedPeds[k], 5, false) 
            SetPedFleeAttributes(CreatedPeds[k], 0, true) 
            SetPedCanCowerInCover(CreatedPeds[k], false) 
            SetPedCombatAttributes(CreatedPeds[k], 0, false) 
            SetPedCanPeekInCover(CreatedPeds[k], false) 
        end

        SetPedSuffersCriticalHits(CreatedPeds[k], v["crits"]) -- crit shots
        SetPedAccuracy(CreatedPeds[k], v["aim"]) -- aim level of ped
        SetPedAlertness(CreatedPeds[k], v["alertness"]) -- high awareness of surroundings
        
        if v["alertness"] == 3 then
            SetPedHighlyPerceptive(CreatedPeds[k], true) -- high perception
        end
        SetCanAttackFriendly(CreatedPeds[k], v["friendlyfire"], false) -- cannot aim at friendlies
        
        
        -- PATHING & COVER
        SetPedPathAvoidFire(CreatedPeds[k], v["avoidshots"]) -- avoid gunshots
        SetPedPathCanUseLadders(CreatedPeds[k], v["ladders"]) -- can use ladders 
        SetPedPathCanUseClimbovers(CreatedPeds[k], v["climb"]) -- can climb
        SetPedPathCanDropFromHeight(CreatedPeds[k], v["drop"]) -- can drop from height
        SetEntityMaxSpeed(CreatedPeds[k], v["movespeed"])

        
        -- WEAPONS
        if v["primary"] then
            GiveWeaponToPed(CreatedPeds[k], 'weapon_'..v["primary"]..'', v["primaryammo"], true, true) -- give gun with 999 ammo. weapon_ is predefined for qol
        end
        if v["secondary"] then
            GiveWeaponToPed(CreatedPeds[k], 'weapon_'..v["primary"]..'', v["primaryammo"], true, true) -- give gun with 999 ammo. weapon_ is predefined for qol
            SetPedCanSwitchWeapon(CreatedPeds[k], true)
        end
       
        if v["infiniteammo"] then
            SetPedInfiniteAmmo(CreatedPeds[k], true, v["primary"])
            SetPedInfiniteAmmo(CreatedPeds[k], true, v["secondary"])
        end
        SetPedInfiniteAmmoClip(CreatedPeds[k], v["infiniteclip"])
        
        if v["attachments"] then
            if v["p1"] then
                GiveWeaponComponentToPed(CreatedPeds[k], 'weapon_'..v["primary"]..'', ''..v["primary"]..'_'..v["p1"]..'') -- give attachment to gun with predefine.
            elseif v["p2"] then
                GiveWeaponComponentToPed(CreatedPeds[k], 'weapon_'..v["primary"]..'', ''..v["primary"]..'_'..v["p2"]..'')
            elseif v["s1"] then
                GiveWeaponComponentToPed(CreatedPeds[k], 'weapon_'..v["secondary"]..'', ''..v["secondary"]..'_'..v["s1"]..'')
            elseif v["s2"] then
                GiveWeaponComponentToPed(CreatedPeds[k], 'weapon_'..v["secondary"]..'', ''..v["secondary"]..'_'..v["s2"]..'')
            end
        end
        SetCurrentPedWeapon(CreatedPeds[k], v["primary"], true)
        

        -- HEALTH
        if v["health"] then
            SetPedMaxHealth(CreatedPeds[k], v["health"])
            SetEntityHealth(CreatedPeds[k], v["health"])
        else
            SetPedMaxHealth(CreatedPeds[k], 100)
            SetEntityHealth(CreatedPeds[k], 100)
        end

        -- ARMOR
        if v["armor"] then
            SetPedArmour(CreatedPeds[k], v["armor"])
        end
        SetEntityInvincible(CreatedPeds[k], v["immortal"])

        if v["target"] then
            exports['qb-target']:AddTargetEntity(CreatedPeds[k], {
                options = {
                    {
                        num = 1,
                        type = v["type"],
                        event = v["event"],
                        icon = v["icon"],
                        label = v["text"],
                        job = v["job"],
                    },
                    {
                        num = 2,
                        type = v["type2"],
                        event = v["event2"],
                        icon = v["icon2"],
                        label = v["text2"],
                        job = v["job2"],
                    },
                },
                distance = 2.0
            })
        end

        -- ASSIGN ROUTE
        if v["route"] then
            TaskPatrol(CreatedPeds[k], 'miss_'..k..'', 0, 1, 1)
        end
    end

    SpawnedPeds = true
    
end)

CreateThread(function()
    while true do
        Wait(Config.DeleteTime)
        if SpawnedPeds then
            for _, v in pairs(CreatedPeds) do
                if IsEntityDead(v) then 
                    DeletePed(v)
                end
            end
        end
    end
end)

function deletePeds()
    if SpawnedPeds then
        for _, v in pairs(CreatedPeds) do
            DeletePed(v)
        end
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deletePeds()
    end
end)

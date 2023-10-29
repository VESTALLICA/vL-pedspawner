Config = {}

Config.DeleteTime = 5000 --- in milliseconds, how long to wait to delete a ped after its death

Config.Peds = {

    ["TemplatePed"] = {
        -- DEFAULT --
        ["coords"] = { vector4(-1953.32, -336.62, 45.82, 223.01), vector4(-1951.9, -335.43, 45.84, 194.09) }, -- multiple spawn points
        ["model"] = { 'ig_abigail', 's_m_y_airworker', 'ig_amandatownley' }, -- supports different models. always leave the last item in a list without a comma, same applies if its singular.
    
        ["relationship"] = "AMBIENT_GANG_BALLAS", -- or nil if none 
        ["playerdmg"] = true, -- true: ped can only be damaged by players. false: can be damaged by all sources.
        ["hostile"] = false, -- will auto attack player
        ["ragdoll"] = false, -- if true then ped will not ragdoll at all. does not work if entity position is frozen
        ["freeze"] = false,  -- freeze entity position
        ["blind"] = false, -- ped will not react to anything and will stay still when hit. 

        -- COMBAT & PATHING --
        ["range"] = 1, -- combat range. 0 = near, 1 = medium, 2 = far
        ["alwaysfight"] = 0, -- 0 = always fight if provoked or hostile, 1 = only fight with weapon, 2 = ped will run from gunshots
        ["crits"] = false, -- false means ped cannot take ANY critical damage. e.g = headshotting this ped will count as a torso shot.   
        ["aim"] = 0, -- 0-100, 100 being perfectly accuracy
        ["alertness"] = 0, -- 0 = neutral, 1 = watchful, 2 = full alert 
        ["friendlyfire"] = 0, -- 0 = cannot aim at friendlies, 1 = can aim at friendlies. does not mean they will attack, but accidental attacks/shots will become possible. i do not think that peds will get revenge if accidentally hit
        
        ["movespeed"] = 1.0, -- 1.0 is default movement speed. 0.9 will get slower, 1.1 will be faster.
        ["movement"] = 1, -- 0 = stationary, 1 = defensive, 2 = offensive  3 = suicidal offensive. defines how a ped will move during combat
        ["avoidshots"] = true, -- if true then ped will move out the way of bullets if being shot at and not frozen or stationary
        ["ladders"] = true, -- if ped can use ladders
        ["climb"] = true, -- if ped can climb and vault things
        ["drop"] = true, -- if ped can drop from heights
        ["route"] = false, -- if the ped has a patrol route it should follow. define routes in routes.lua.
        
        ["wander"] = false, -- route must be false. ped will instead wander around 
        ["radius"] = 0.0, -- wander in spawned area with radius of 100 meters. must end in decimal value.
        ["walk"] = 5, -- distance in meters that the ped will walk
        ["wait"] = 10.0, -- how long the ped will wait after walking X meters ^

        ["scenario"] = { 'WORLD_HUMAN_HIKER' }, -- some scenarios that the ped can play on spawn. wander and route must be off. ped can be brought out of anim if not blind. list of gta scenarios: pastebin.com/6mrYTdQv
        --["scenario"] = false, -- leave false if no scenario. 

        -- WEAPONS --
        ["primary"] = 'assaultrifle', -- input just weapon: 'assaultrifle' 'microsmg' 'appistol'. weapon_ is predefined in the code
        ["primaryammo"] = 999, -- starting ammo for the primary weapon on spawn. 999 seems to be the max.
        ["secondary"] = nil, -- leave nil if no weapon
        ["secondaryammo"] = 999, -- starting ammo for the secondary weapon on spawn.

        ["infiniteammo"] = true, -- if ped has infinite ammo. ammo in clip will still deplete.
        ["infiniteclip"] = true, -- if ped has infinite clip, meaning they will never have to reload.

        ["attachments"] = false, -- must declare
        ["p1"] = '', -- input just attachment for primary/secondary: 'defaultclip' , 'extendedclip' 'scope'
        ["p2"] = '', -- primary attachment 2
        ["s1"] = '', -- secondary attachment 1
        ["s2"] = '', -- secondary attachment 2


       -- HEALTH --
       ["health"] = 200, -- health. female models cannot exceed 100
       ["armor"] = 0, -- leave 0 if no armor. 
       ["immortal"] = false, -- cannot die


       -- QB TARGET ENTITY SUPPORT --
       ["target"] = false, 
       ["type"] = "client",
       ["event"] = "do:something", 
       ["icon"] = "icon",
       ["text"] = "Something", 
       ["job"] = false,
    
       -- second option in target
       ["type2"] = "server",
       ["event2"] = "do:something2", 
       ["icon2"] = "icon2", -- The icon that shows up
       ["text2"] = "Something", 
       ["job2"] = false,
    },

}

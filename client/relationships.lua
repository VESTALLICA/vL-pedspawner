local QBCore = exports['qb-core']:GetCoreObject()

--[[
you do not have to do the AMBIENT_GANG mess when creating relationships. 

["relationship"] = "bloods", use "bloods" "crips" when in the config. not Bloods or Crips

SetRelationshipBetweenGroups(0,  
0 = Companion  
1 = Respect  
2 = Like  
3 = Neutral  
4 = Dislike  
5 = Hate  
]]

-- edit the following template to your liking
_, Bloods = AddRelationshipGroup("bloods")
_, Crips = AddRelationshipGroup("crips")



SetRelationshipBetweenGroups(0, Bloods, Bloods) -- set bloods to be companions with other bloods
SetRelationshipBetweenGroups(5, Bloods, Crips) -- set bloods to hate crips

SetRelationshipBetweenGroups(0, Crips, Crips) -- set crips to be companions with other crips
SetRelationshipBetweenGroups(5, Crips, Bloods) -- set crips to hate bloods
SetRelationshipBetweenGroups(5, Crips, GetHashKey("AMBIENT_GANG_BALLAS")) -- set crips to hate the ballas
-- do GetHashKey(string) for strings you do not know the hash of

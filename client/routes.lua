local QBCore = exports['qb-core']:GetCoreObject()

-- create patrol routes 

CreatePatrolRoute('miss_TemplatePed') --  must start with 'miss_' and end in the peds name. the ped will start the route as soon as they spawn
OpenPatrolRoute('miss_TemplatePed') 
AddPatrolRouteNode(0, "WORLD_HUMAN_GUARD_STAND", vector3(0, 0, 0), --[[]] vector3(1, 1, 1), 3000) -- ped will go to vector3(0, 0, 0) and face vector3(1, 1, 1) for 3000 milliseconds
AddPatrolRouteNode(1, "WORLD_HUMAN_GUARD_STAND", vector3(0, 0, 0), --[[]] vector3(1, 1, 1), 3000)
AddPatrolRouteNode(2, "WORLD_HUMAN_GUARD_STAND", vector3(0, 0, 0), --[[]] vector3(1, 1, 1), 3000)
AddPatrolRouteLink(0, 1) -- position 1
AddPatrolRouteLink(1, 2)
AddPatrolRouteLink(2, 1)
AddPatrolRouteLink(1, 0) -- will then loop back to position 1
ClosePatrolRoute('miss_TemplatePed') 


DeletePatrolRoute('miss_TemplatePed') -- must clear the previously created patrol route to create and open a new one. this will not literally delete it and the ped will still follow the previous route.
CreatePatrolRoute('miss_TemplatePed2')  
OpenPatrolRoute('miss_TemplatePed2')  
AddPatrolRouteNode(0, "WORLD_HUMAN_GUARD_STAND", vector3(0, 0, 0), --[[]] vector3(1, 1, 1), 3000) -- ped will go to vector3(0, 0, 0) and face vector3(1, 1, 1) for 3000 milliseconds
AddPatrolRouteNode(1, "WORLD_HUMAN_GUARD_STAND", vector3(0, 0, 0), --[[]] vector3(1, 1, 1), 3000)
AddPatrolRouteNode(2, "WORLD_HUMAN_GUARD_STAND", vector3(0, 0, 0), --[[]] vector3(1, 1, 1), 3000)
AddPatrolRouteLink(0, 1) -- position 1
AddPatrolRouteLink(1, 2)
AddPatrolRouteLink(2, 1)
AddPatrolRouteLink(1, 0) -- will then loop back to position 1
ClosePatrolRoute('miss_TemplatePed2')
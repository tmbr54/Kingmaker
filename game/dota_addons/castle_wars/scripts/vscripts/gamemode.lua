-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode


-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false 

if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end



-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/GetCollisionPadding()ion of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')
-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')





  GameRules:SetUseBaseGoldBountyOnHeroes(false)






--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  DebugPrint("[BAREBONES] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
  --PrecacheUnitByNameAsync("race_2_building_placer", function(...) end)
  --PrecacheUnitByNameAsync("race_2_melee_tier_1_footman", function(...) end)


end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[BAREBONES] First Player has loaded")


end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  DebugPrint("[BAREBONES] All Players have loaded into the game")



end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]



--own functions
--teams: 2, 3, 6, 7, 8
--player:
-- Team 2:
-- Team 3:
-- Team 4:
-- Team 5:



  --when hero spawns, get his team and check if his team already has the building spawners. if not make new ones.
function SetUpBuildingSpawners(teamID, hero, numberOfBuildings)


  for i=1,numberOfBuildings,1 do
    --print("race_"..teamID.."_spawner_"..i)
    local spawner_position = Entities:FindByName(nil, "race_"..teamID.."_spawner_"..i):GetAbsOrigin()
    local building = CreateUnitByName("race_"..teamID.."_building_placer", spawner_position, true, hero, hero, teamID)
    
    building:SetAbsOrigin(spawner_position)
    --FindClearSpaceForUnit(building, spawner_position, true)
    building:AddNewModifier(building, nil, "modifier_invulnerable", nil)
    building:NoHealthBar()
    local forwardVector = Entities:FindByName(nil, "race_"..teamID.."_spawner_"..i):GetForwardVector() 
    building:SetForwardVector(forwardVector)

  end

  for i=1,10,1 do --10 tower

    local tower_position = Entities:FindByName(nil, "race_"..teamID.."_tower_"..i):GetAbsOrigin()
    local tower = CreateUnitByName("race_"..teamID.."_tower_placer", tower_position, true, hero, hero, teamID)
    tower:SetAbsOrigin(tower_position)
    tower:AddNewModifier(tower, nil, "modifier_invulnerable", nil)
    tower:NoHealthBar()
    local forwardVector = Entities:FindByName(nil, "race_"..teamID.."_tower_"..i):GetForwardVector() 
    tower:SetForwardVector(forwardVector)
  end

end





  --reset the kings

function SetUpKings(teamID, hero) 
  local king_position = Entities:FindByName(nil, "race_"..teamID.."_king_position"):GetAbsOrigin()
  local king = CreateUnitByName("race_"..teamID.."_king", king_position, true, nil, nil, teamID)
  king:SetForwardVector(king_position)
  local forwardVector = Entities:FindByName(nil, "race_"..teamID.."_king_position"):GetForwardVector() 
  king:SetForwardVector(forwardVector)

  --remove blockers from base
  team_blockers = {}
  local team_blockers = Entities:FindAllByName("race_"..teamID.."_blocker")
  
  print("Removing base blockers...")
  for k,blocker in pairs(team_blockers) do
    local position = blocker:GetAbsOrigin()
    
    blocker:RemoveSelf()
    --remove trees
  end

  
  --print("created a king for team",teamID)

end
-- 

 --set up vision--

function CreateVision(teamID, hero)


  for i=1,10,1 do
    
    local vision_spawner = Entities:FindByName(nil, "race_"..teamID.."_vision_"..i)
    local middle_vision_spawner = Entities:FindByName(nil, "race_"..teamID.."_fow")
    if vision_spawner ~= nil then
      local vision_spawner_position = vision_spawner:GetAbsOrigin()
      AddFOWViewer(teamID, vision_spawner_position, 3000, 120000, false)
      --print("added vision base")
    end
    if middle_vision_spawner ~= nil then
      local middle_vision_spawner_position = middle_vision_spawner:GetAbsOrigin()
      AddFOWViewer(teamID, middle_vision_spawner_position, 1300, 120000, false)
      --print("added vision mid")
    end
  end

end

function GameMode:OnHeroInGame(hero)
  DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())
  hero:SetGold(startingGold, false)

  --print("PlayerID ",hero:GetPlayerID())
  teamID = hero:GetTeamNumber()
  --print("teamID : " .. teamID)
  
 --test unit
 --  local hPlayer = hero:GetPlayerOwner()
 --  --print("playerowner")
 --  PrintTable(hPlayer)
 --  local hPlayer = hero:GetOwner()
 --  --print(" owner")
 --  PrintTable(hPlayer)
 --  local hID = hero:GetPlayerOwnerID()
 -- --print("hid", hid)
 --  local spawned_unit = CreateUnitByName("race_7_melee_tier_1_footman", hero:GetAbsOrigin(), true, hero, hero, hero:GetTeamNumber())
 --  --print("su_id", spawned_unit:GetPlayerOwnerID())
 --  spawned_unit:SetControllableByPlayer(hero:GetPlayerID(), true)


  --retarded code follows because I didn't realize FindAllByName was a thing


  if (table.containsValue(visionTable, teamID) == false) then 
    print("Adding vision ...")
    CreateVision(teamID, hero)
    visionTable[#visionTable+1] = teamID
  end



  if (table.containsValue(kingTable, teamID) == false) then
    print("Setting up kings ... ")
    SetUpKings(teamID, hero)
    kingTable[#kingTable+1] = teamID
  end
    
  if (table.containsValue(bsUnitTable, teamID) == false) then
      print("Creating buildings ...")
      SetUpBuildingSpawners(teamID, hero, 48) --48 barracks is standard
      bsUnitTable[#bsUnitTable+1] = teamID
  end    


  -- print("TeamID" .. teamID)

  -- if table.contains(teamTable, teamID) == true then
  --     for k,v in pairs(teamTable) do
  --       print("team" .. k  .. " has ID : " .. v)
  --     end


 



  -- -- These lines will create an item and add it to the player, effectively ensuring they start with the item
  -- local item = CreateItem("item_example_item", hero, hero)
  -- hero:AddItem(item)

  --[[ --These lines if uncommented will replace the W ability of any hero that loads into the game
    --with the "example_ability" ability

  local abil = hero:GetAbilityByIndex(1)
  hero:RemoveAbility(abil:GetAbilityName())
  hero:AddAbility("example_ability")]]
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
  DebugPrint("[BAREBONES] The game has officially begun")

--gold tick timer
print("Gold tick timer started")
Timers:CreateTimer( function()
  for i=0,20,1 do 
    local iPlayerID = i
    if PlayerResource:IsValidPlayer(iPlayerID) then 
      local teamID = PlayerResource:GetTeam(iPlayerID)
      local permanentIncome = 0.2 * populationTable[teamID]
      local temporaryIncome = 0.4 * unitOutsideBaseTable[teamID]
      goldAmount = 6 + permanentIncome + temporaryIncome
      goldAmount = math.floor(goldAmount)
      PlayerResource:ModifyGold(i, goldAmount, true, 10)
      --print(goldAmount, " tick gold has been awarded to", iPlayerID)
      
    end
  end
return tickTime
end
)





  Timers:CreateTimer(30, -- Start this timer 30 game-time seconds later
    function()
      DebugPrint("This function is called 30 seconds after the game begins, and every 30 seconds thereafter")
      return 30.0 -- Rerun this timer every 30 game-time seconds 
    end)
end

function GameMode:ModifyGoldFilter(event)
    
    if event.reason_const == DOTA_ModifyGold_HeroKill then
      return false
    end
    if event.reason_const == DOTA_ModifyGold_Death then
      return false
    end
  return true
end


function GameMode:OrderFilter( filterTable )
  --[[for k, v in pairs( filterTable ) do
          print("Order: " .. k .. " " .. tostring(v) )
  end]]


  local units = filterTable["units"]
  local order_type = filterTable["order_type"]
  local issuer = filterTable["issuer_player_id_const"]
  local abilityEntityIndex = filterTable["entindex_ability"]
  local targetIndex = filterTable["entindex_target"]
  local x = tonumber(filterTable["position_x"])
  local y = tonumber(filterTable["position_y"])
  local z = tonumber(filterTable["position_z"])
  local point = Vector(x,y,z)
  --repairing purchase items
  if order_type == 16 then
    --print("purchased an item")
    return true
  end

  --checking for barracks upgrade spell
  --print("abilityEntityIndex: ", abilityEntityIndex)
  if abilityEntityIndex and abilityEntityIndex ~= 0 and abilityEntityIndex ~= -1 then 

    local ability = EntIndexToHScript(abilityEntityIndex)
    local abilityName = ability:GetAbilityName()
    

    
    if table.containsValue(bsAbilityNameTable, abilityName) then
      if table.containsKey(bsSpawnerTable, abilityEntityIndex ) ~= true then
        table.insert(bsSpawnerTable, abilityEntityIndex, issuer)
        
        --[[for k,v in pairs(bsSpawnerTable) do
          print("k " .. k  .. " , v  " .. v)
        end]]
      end  
      return true
    end
  end
  
return true


end






-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self

  DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')

  -- Call the internal function to set up the rules/behaviors specified in constants.lua
  -- This also sets up event hooks for all event handlers in events.lua
  -- Check out internals/gamemode to see/modify the exact code
  GameMode:_InitGameMode()
  GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(GameMode, 'OrderFilter'), self) 
  GameRules:GetGameModeEntity():SetModifyGoldFilter(Dynamic_Wrap(GameMode, "ModifyGoldFilter"), GameMode)

  CustomGameEventManager:RegisterListener( "update_selected_entities", Dynamic_Wrap(GameMode, 'OnPlayerSelectedEntities'))
  GameRules.SELECTED_UNITS = {}


  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )


  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
end





function GameMode:OnPlayerSelectedEntities( event )
  local pID = event.pID

  GameRules.SELECTED_UNITS[pID] = event.selected_entities

end


-- This is an example console command
function GameMode:ExampleConsoleCommand()
  print( '******* Example Console Command ***************' )
  local cmdPlayer = Convars:GetCommandClient()
  if cmdPlayer then
    local playerID = cmdPlayer:GetPlayerID()
    if playerID ~= nil and playerID ~= -1 then
      -- Do something here for the player who called this command
      PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_viper", 1000, 1000)
    end
  end

  print( '*********************************************' )
end




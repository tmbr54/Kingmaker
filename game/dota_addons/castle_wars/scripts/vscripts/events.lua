-- This file contains all barebones-registered events and has already set up the passed-in parameters for your use.
-- Do not remove the GameMode:_Function calls in these events as it will mess with the internal barebones systems.

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
  DebugPrint('[BAREBONES] Player Disconnected ' .. tostring(keys.userid))
  DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid

end
-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
  DebugPrint("[BAREBONES] GameRules State Changed")
  DebugPrintTable(keys)

  -- This internal handling is used to set up main barebones functions
  GameMode:_OnGameRulesStateChange(keys)

  local newState = GameRules:State_Get()
end

-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
  DebugPrint("[BAREBONES] NPC Spawned")
  DebugPrintTable(keys)

  -- This internal handling is used to set up main barebones functions
  GameMode:_OnNPCSpawned(keys)

  local npc = EntIndexToHScript(keys.entindex)
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
  --DebugPrint("[BAREBONES] Entity Hurt")
  --DebugPrintTable(keys)

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless
  if keys.entindex_attacker ~= nil and keys.entindex_killed ~= nil then
    local entCause = EntIndexToHScript(keys.entindex_attacker)
    local entVictim = EntIndexToHScript(keys.entindex_killed)

    -- The ability/item used to damage, or nil if not damaged by an item/ability
    local damagingAbility = nil

    if keys.entindex_inflictor ~= nil then
      damagingAbility = EntIndexToHScript( keys.entindex_inflictor )
    end
  end
end

-- An item was picked up off the ground
function GameMode:OnItemPickedUp(keys)
  DebugPrint( '[BAREBONES] OnItemPickedUp' )
  DebugPrintTable(keys)

  local heroEntity = EntIndexToHScript(keys.HeroEntityIndex)
  local itemEntity = EntIndexToHScript(keys.ItemEntityIndex)
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local itemname = keys.itemname
end

-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys)
  DebugPrint( '[BAREBONES] OnPlayerReconnect' )
  DebugPrintTable(keys) 
end

-- An item was purchased by a player
function GameMode:OnItemPurchased( keys )
  DebugPrint( '[BAREBONES] OnItemPurchased' )
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
  
end

-- An ability was used by a player
function GameMode:OnAbilityUsed(keys)
  DebugPrint('[BAREBONES] AbilityUsed')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityname = keys.abilityname
end

-- A non-player entity (necro-book, chen creep, etc) used an ability
function GameMode:OnNonPlayerUsedAbility(keys)
  DebugPrint('[BAREBONES] OnNonPlayerUsedAbility')
  DebugPrintTable(keys)

  local abilityname=  keys.abilityname
end

-- A player changed their name
function GameMode:OnPlayerChangedName(keys)
  DebugPrint('[BAREBONES] OnPlayerChangedName')
  DebugPrintTable(keys)

  local newName = keys.newname
  local oldName = keys.oldName
end

-- A player leveled up an ability
function GameMode:OnPlayerLearnedAbility( keys)
  DebugPrint('[BAREBONES] OnPlayerLearnedAbility')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local abilityname = keys.abilityname
end

-- A channelled ability finished by either completing or being interrupted
function GameMode:OnAbilityChannelFinished(keys)
  DebugPrint('[BAREBONES] OnAbilityChannelFinished')
  DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

-- A player leveled up
function GameMode:OnPlayerLevelUp(keys)
  DebugPrint('[BAREBONES] OnPlayerLevelUp')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local level = keys.level
end

-- A player last hit a creep, a tower, or a hero
function GameMode:OnLastHit(keys)
  DebugPrint('[BAREBONES] OnLastHit')
  DebugPrintTable(keys)

  local isFirstBlood = keys.FirstBlood == 1
  local isHeroKill = keys.HeroKill == 1
  local isTowerKill = keys.TowerKill == 1
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local killedEnt = EntIndexToHScript(keys.EntKilled)
end

-- A tree was cut down by tango, quelling blade, etc
function GameMode:OnTreeCut(keys)
  DebugPrint('[BAREBONES] OnTreeCut')
  DebugPrintTable(keys)

  local treeX = keys.tree_x
  local treeY = keys.tree_y
end

-- A rune was activated by a player
function GameMode:OnRuneActivated (keys)
  DebugPrint('[BAREBONES] OnRuneActivated')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local rune = keys.rune

  --[[ Rune Can be one of the following types
  DOTA_RUNE_DOUBLEDAMAGE
  DOTA_RUNE_HASTE
  DOTA_RUNE_HAUNTED
  DOTA_RUNE_ILLUSION
  DOTA_RUNE_INVISIBILITY
  DOTA_RUNE_BOUNTY
  DOTA_RUNE_MYSTERY
  DOTA_RUNE_RAPIER
  DOTA_RUNE_REGENERATION
  DOTA_RUNE_SPOOKY
  DOTA_RUNE_TURBO
  ]]
end

-- A player took damage from a tower
function GameMode:OnPlayerTakeTowerDamage(keys)
  DebugPrint('[BAREBONES] OnPlayerTakeTowerDamage')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local damage = keys.damage
end

-- A player picked a hero
function GameMode:OnPlayerPickHero(keys)
  DebugPrint('[BAREBONES] OnPlayerPickHero')
  DebugPrintTable(keys)

  local heroClass = keys.hero
  local heroEntity = EntIndexToHScript(keys.heroindex)
  local player = EntIndexToHScript(keys.player)
end

-- A player killed another player in a multi-team context
function GameMode:OnTeamKillCredit(keys)
  DebugPrint('[BAREBONES] OnTeamKillCredit')
  DebugPrintTable(keys)

  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
  local numKills = keys.herokills
  local killerTeamNumber = keys.teamnumber
end

-- An entity died
function GameMode:OnEntityKilled( keys )
  DebugPrint( '[BAREBONES] OnEntityKilled Called' )
  DebugPrintTable( keys )



  GameMode:_OnEntityKilled( keys ) 
  


  -- The Unit that was Killed
  local killedUnit = EntIndexToHScript( keys.entindex_killed )

  

  -- The Killing entity
  local killerEntity = nil

  if keys.entindex_attacker ~= nil then
    killerEntity = EntIndexToHScript( keys.entindex_attacker )
  end

  -- The ability/item used to kill, or nil if not killed by an item/ability
  local killerAbility = nil

  if keys.entindex_inflictor ~= nil then
    killerAbility = EntIndexToHScript( keys.entindex_inflictor )
  end

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless

  -- Put code here to handle when an entity gets killed
  if killerEntity:GetOwner() then
    local killermann = killerEntity:GetOwner()
    local killerID = killermann:GetPlayerID() 
    print("The killer ", killerEntity:GetUnitName(),"now has ", PlayerResource:GetGold(killerID), "gold")
  end

  
  
  
  --rewritten kill + death + assist gold
  if killedUnit:IsHero() then 
    print("hero got killed")
    --make sure its an actual owned unit that killed him
    if killerEntity:GetOwner() and killerEntity.GetOwner then
      --print("Valid Unit")
      local goldForKilledHero = heroGoldTable[killedUnit:GetLevel()]
      local killerPlayer = killerEntity:GetOwner()
      --grant gold to killer

      --check for first blood
      if first_blood_check then
        PlayerResource:ModifyGold(killerPlayer:GetPlayerID(), goldForKilledHero * 2, false, 12)
        PopupGoldGain(killerEntity, goldForKilledHero * 2, killerEntity:GetTeamNumber())
        GameRules:SetFirstBloodActive(false)
        first_blood_check = false
        print("first blood has been spilled")
        print("granted", goldForKilledHero * 2, "gold to", killerPlayer:GetPlayerID() )
      --regular kill
      else
        PopupGoldGain(killerEntity, goldForKilledHero, killerEntity:GetTeamNumber())
        PlayerResource:ModifyGold(killerPlayer:GetPlayerID(), goldForKilledHero, false, 12)
        print("granted", goldForKilledHero, "gold to", killerPlayer:GetPlayerID() )
      end
      

      --remove gold from killed
      local killedPlayer = killedUnit:GetOwner()
      PlayerResource:ModifyGold(killedPlayer:GetPlayerID(), -goldForKilledHero * 1.3, false, 1) 
      print("removed", goldForKilledHero * 1.3, "gold from ", killedPlayer:GetPlayerID() )

      --find all units in a 900 radius area and save them in a table
      local all_units = Entities:FindAllInSphere(killedUnit:GetAbsOrigin(), 900)
      local assist_heroes = {}
      for k,unit in pairs(all_units) do 
        --add all heroes in the same team found to a different table
        if (unit.IsHero and unit:IsHero()) and (killerEntity:GetTeamNumber() == unit:GetTeamNumber() ) then
          table.insert(assist_heroes, unit)
          --print("inserted hero ", unit:GetUnitName(), "into assist_heroes")
        end
      end
      --calculate assist gold
      local number_of_heroes = table.getn(assist_heroes)
      local assistGoldAmount = ((goldForKilledHero * 0.35) / number_of_heroes + (goldForKilledHero * 0.1))
      assistGoldAmount = math.floor(assistGoldAmount)
      --start granting assist gold
      if number_of_heroes >= 2 then
        for i=1,number_of_heroes,1 do
          local assist_hero = assist_heroes[i]
          --print("test for GetMostRecentDamageTime", assist_hero:GetUnitName(), assist_hero:GetMostRecentDamageTime()) --broken
          --make sure the killer doesnt get his own assist gold
          if assist_hero:GetPlayerID() ~= killerPlayer:GetPlayerID() then 
            assist_hero:ModifyGold(assistGoldAmount, false, 12)
            print("granted ", assistGoldAmount, "gold to ", assist_hero:GetPlayerID())
            PopupGoldGain(assist_hero, assistGoldAmount, killerEntity:GetTeamNumber())

          end
        end
      end
    end
  end


-- --standard units die
--removed because pop limit doesnt really have a use and is now used to calculate gold income 
--   if killedUnit:HasModifier("has_population_1") then
--     --print("Killed unit had a Population of 1")
--     currentpop = GetPopulationNumber(killedUnit:GetTeamNumber())
--     RemoveFromPopulation(killedUnit:GetTeamNumber(), 1)  
--   end

--   if killedUnit:HasModifier("has_population_2") then
--     --print("Killed unit had a Population of 2")
--     currentpop = GetPopulationNumber(killedUnit:GetTeamNumber())
--     RemoveFromPopulation(killedUnit:GetTeamNumber(), 2)
--   end  


--   if killedUnit:HasModifier("has_population_3") then
--     --print("Killed unit had a Population of 2")
--     currentpop = GetPopulationNumber(killedUnit:GetTeamNumber())
--     RemoveFromPopulation(killedUnit:GetTeamNumber(), 3)

--   if killedUnit:HasModifier("has_population_5") then 
--     --print("Killed unit had a Population of 5")
--     currentpop = GetPopulationNumber(killedUnit:GetTeamNumber())
--     RemoveFromPopulation(killedUnit:GetTeamNumber(), 5)
--   end


--   if killedUnit:HasModifier("has_population_10") then
--     --print("Killed unit had a Population of 10")
--     currentpop = GetPopulationNumber(killedUnit:GetTeamNumber())
--     RemoveFromPopulation(killedUnit:GetTeamNumber(), 10)
--   end
--   end  

--


  --king dies
  local remaining_kings = {}
  if killedUnit:HasModifier("is_king") then
    losingTeam = killedUnit:GetTeam()
    print("Team ",losingTeam," has lost.")
    --add popup for team here
    --find all units
    local all_units = Entities:FindAllInSphere(Vector(0,0,0), 12000.0)
    for number,entity in pairs(all_units) do
      
      if entity:GetTeam() == losingTeam then
        --print("number", number, "entity", entity:GetName())
        if entity ~= killedUnit then
          --print("removing unit..", entity:GetName())
         entity:RemoveSelf()
        end
      end
      if IsValidEntity(entity) and entity.HasModifier and entity:HasModifier("is_king") then
        print("found a king")
        table.insert(remaining_kings, entity)
      end
    end
    print(table.getn(remaining_kings))
    if table.getn(remaining_kings) <= 2 then
      
      for k,v in pairs(remaining_kings) do
        if v ~= killedUnit then
          winning_team = v:GetTeam()
          print("Winner has been found: ", winning_team)
          --print winner message

          GameRules:SetGameWinner(winning_team)
          GameRules:SetSafeToLeave(true)
          GameRules:Defeated()

        end
      end
    end
  end
end



-- This function is called 1 to 2 times as the player connects initially but before they 
-- have completely connected
function GameMode:PlayerConnect(keys)
  DebugPrint('[BAREBONES] PlayerConnect')
  DebugPrintTable(keys)
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)
  DebugPrint('[BAREBONES] OnConnectFull')
  DebugPrintTable(keys)

  GameMode:_OnConnectFull(keys)
  
  local entIndex = keys.index+1
  -- The Player entity of the joining user
  local ply = EntIndexToHScript(entIndex)
  
  -- The Player ID of the joining player
  local playerID = ply:GetPlayerID()
end

-- This function is called whenever illusions are created and tells you which was/is the original entity
function GameMode:OnIllusionsCreated(keys)
  DebugPrint('[BAREBONES] OnIllusionsCreated')
  DebugPrintTable(keys)

  local originalEntity = EntIndexToHScript(keys.original_entindex)
end

-- This function is called whenever an item is combined to create a new item
function GameMode:OnItemCombined(keys)
  DebugPrint('[BAREBONES] OnItemCombined')
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end
  local player = PlayerResource:GetPlayer(plyID)

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
end

-- This function is called whenever an ability begins its PhaseStart phase (but before it is actually cast)
function GameMode:OnAbilityCastBegins(keys)
  DebugPrint('[BAREBONES] OnAbilityCastBegins')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityName = keys.abilityname
end

-- This function is called whenever a tower is killed
function GameMode:OnTowerKill(keys)
  DebugPrint('[BAREBONES] OnTowerKill')
  DebugPrintTable(keys)

  local gold = keys.gold
  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local team = keys.teamnumber
end

-- This function is called whenever a player changes there custom team selection during Game Setup 
function GameMode:OnPlayerSelectedCustomTeam(keys)
  DebugPrint('[BAREBONES] OnPlayerSelectedCustomTeam')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.player_id)
  local success = (keys.success == 1)
  local team = keys.team_id
end

-- This function is called whenever an NPC reaches its goal position/target
function GameMode:OnNPCGoalReached(keys)
  DebugPrint('[BAREBONES] OnNPCGoalReached')
  DebugPrintTable(keys)

  local goalEntity = EntIndexToHScript(keys.goal_entindex)
  local nextGoalEntity = EntIndexToHScript(keys.next_goal_entindex)
  local npc = EntIndexToHScript(keys.npc_entindex)
end
populationTable = { [-1] = 0, [0] = 0, [1] = 0,[2] = 0, [3] = 0, [6] = 0, [7] =  0, [8] = 0}
unitOutsideBaseTable = { [-1] = 0, [0] = 0, [1] = 0,[2] = 0, [3] = 0, [6] = 0, [7] =  0, [8] = 0}


populationLimit = 5000

first_blood_check = true
GameRules:SetFirstBloodActive(true)
tickTime = 30
startingGold = 234 --change
kingTable = {}
visionTable = {} 
bsUnitTable = {}
race_color_table = {[2] =  Vector(245, 245, 213), [3] =  Vector(220, 16, 213), [6] =  Vector(156, 115, 95), [7] =  Vector(51, 153, 255), [8] =  Vector(82, 166, 92)}
bsSpawnerTable = {}
bsAbilityNameTable = {"race_2_claim_barracks", "race_3_claim_barracks", "race_6_claim_barracks", "race_7_claim_barracks", "race_8_claim_barracks", 
  "upgrade_to_race_2_tower_1", 
  "upgrade_to_race_3_tower_1", 
  "upgrade_to_race_6_tower_1", 
  "upgrade_to_race_7_tower_1", 
  "upgrade_to_race_8_tower_1"}
rallyPointPerUnitTable = {}





heroGoldTable = { 
[1] = 50,
[2] = 90,
[3] = 140,
[4] = 160,
[5] = 200,
[6] = 250,
[7] = 280,
[8] = 310,
[9] = 330,
[10] = 350,
[11] = 400,
[12] = 420,
[13] = 440,
[14] = 460,
[15] = 480,
[16] = 550,
[17] = 580,
[18] = 610,
[19] = 640,
[20] = 670
}

function MoveToRallyPoint( unit, rallyPoint )
	if rallyPoint == nil then
		local rallyPoint = Entities:FindByName(nil, "entity_map_middle"):GetAbsOrigin()
		--print("rallyPoint", rallyPoint)
	end
    ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(), 
                            OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                            Position = rallyPoint, Queue = true })
    --print(unit:GetUnitName().." moving to position",rallyPoint)
end

 

function RemoveGold(iPlayerID, iAmount, iReason)
	local iCurrentGold = PlayerResource:GetGold(iPlayerID)
	--print("iCurrentGold", iCurrentGold)
	local iNewGold = iCurrentGold - iAmount
	--print ("iNewGold ", iNewGold)
	if iNewGold < 0 then
		print("Player ",iPlayerID," did not have enough gold.")
		return false
	else
		PlayerResource:SpendGold(iPlayerID, iAmount, 7)
		--print("Player",iPlayerID,"'s Gold is now: ",iNewGold)
		return true
	end
end


function table.containsValue(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function table.containsKey(table, element)
  for key,_ in pairs(table) do
    if key == element then
      return true
    end
  end
  return false
end


function GetPopulationNumber(teamNumber)
	return populationTable[teamNumber]
end


function AddToPopulation(teamNumber, pop)
	populationTable[teamNumber] = populationTable[teamNumber] + pop 
	--for k,v in pairs(populationTable) do
	--	print("Population of Team " .. k  .. " : " .. v)
	--end	
end

function RemoveFromPopulation(teamNumber, pop)
	if populationTable[teamNumber] > 0 then
		populationTable[teamNumber] = populationTable[teamNumber] - pop
		--for k,v in pairs(populationTable) do
		--	print("Population of Team " .. k .. " : " .. v)
		--end	
	end
	
end


function AddUnitToSelection( unit )
    local player = unit:GetPlayerOwner() 
    CustomGameEventManager:Send_ServerToPlayer(player, "add_to_selection", { ent_index = unit:GetEntityIndex() })
end

function RemoveUnitFromSelection( unit )
    local player = unit:GetPlayerOwner()
    local ent_index = unit:GetEntityIndex()
    CustomGameEventManager:Send_ServerToPlayer(player, "remove_from_selection", { ent_index = unit:GetEntityIndex() })
end

function GetSelectedEntities( playerID )
    return GameRules.SELECTED_UNITS[playerID]
end

function IsCurrentlySelected( unit )
    local entIndex = unit:GetEntityIndex()
    local playerID = unit:GetPlayerOwnerID()
    local selectedEntities = GetSelectedEntities( playerID )
    for _,v in pairs(selectedEntities) do
        if v==entIndex then
            return true
        end
    end
    return false
end

function GetMainSelectedEntity( playerID )
    if GameRules.SELECTED_UNITS[playerID]["0"] then
        return EntIndexToHScript(GameRules.SELECTED_UNITS[playerID]["0"])
    end
    return nil
end


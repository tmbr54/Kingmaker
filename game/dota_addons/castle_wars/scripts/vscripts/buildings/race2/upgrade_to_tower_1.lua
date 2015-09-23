-- Human Tower
-- Creates a DOTA unit by its dota_npc_units.txt name ( szUnitName, vLocation, bFindClearSpace, hNPCOwner, hUnitOwner, iTeamNumber )
function cast_upgrade(event)
	entityIndex = event.ability:GetEntityIndex()
	--print("entityIndex : ", entityIndex)
	iPlayerID = bsSpawnerTable[entityIndex] 
	--print("iPlayerID : ", iPlayerID)
	upgrade_to_tower(event, iPlayerID)
end


function upgrade_to_tower(event, iPlayerID)

	local caster = event.caster
	--print("iPlayerID :", iPlayerID )
	local vPosition = event.caster:GetAbsOrigin()
	local hPlayer = PlayerResource:GetPlayer(iPlayerID)
	local iTeamNumber = hPlayer:GetTeamNumber()
	
	 
	if RemoveGold(iPlayerID, 250, false) == true then
		local tower = CreateUnitByName("race_2_tower_1", vPosition + Vector(0,0,0), false, hPlayer, hPlayer, iTeamNumber)
		tower:SetControllableByPlayer(iPlayerID, true)
		print("tower_id", tower:GetPlayerOwnerID())


	 	local particlePosition = tower:GetAbsOrigin()
		local upgradeParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_quill_spray_ring_dust.vpcf", PATTACH_ABSORIGIN_FOLLOW, tower)
		ParticleManager:SetParticleControl(upgradeParticle, 0, tower:GetAbsOrigin())
	 	local claimParticle = ParticleManager:CreateParticleForPlayer("particles/econ/courier/courier_baekho/courier_baekho_ambient.vpcf", PATTACH_OVERHEAD_FOLLOW, tower, PlayerResource:GetPlayer(iPlayerID)) 
	 	ParticleManager:SetParticleControl(claimParticle, 0, particlePosition - Vector(50,0,0))


     	AddUnitToSelection(tower)
     	UTIL_Remove(event.caster)

	end
end


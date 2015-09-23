-- Outworld Barracks
-- Creates a DOTA unit by its dota_npc_units.txt name ( szUnitName, vLocation, bFindClearSpace, hNPCOwner, hUnitOwner, iTeamNumber )
function cast_upgrade(event)
	entityIndex = event.ability:GetEntityIndex()
	--print("entityIndex : ", entityIndex)
	iPlayerID = bsSpawnerTable[entityIndex] 
	--print("iPlayerID : ", iPlayerID)
	upgrade_to_barracks(event, iPlayerID)
end


function upgrade_to_barracks(event, iPlayerID)
	print("iPlayerID :", iPlayerID )
	local vPosition = event.caster:GetAbsOrigin()
	local hPlayer = PlayerResource:GetPlayer(iPlayerID)
	local iTeamNumber = hPlayer:GetTeamNumber()
	
	 
	if RemoveGold(iPlayerID, 50, false) == true then
		local barracks = CreateUnitByName("race_3_barracks", vPosition + Vector(0,0,200), false, hPlayer, hPlayer, iTeamNumber)
		
		barracks:SetControllableByPlayer(iPlayerID, true)

	 	local particlePosition = barracks:GetAbsOrigin()
		local upgradeParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_quill_spray_ring_dust.vpcf", PATTACH_ABSORIGIN_FOLLOW, barracks)
		ParticleManager:SetParticleControl(upgradeParticle, 0, barracks:GetAbsOrigin())
	 	local claimParticle = ParticleManager:CreateParticleForPlayer("particles/econ/courier/courier_baekho/courier_baekho_ambient.vpcf", PATTACH_OVERHEAD_FOLLOW, barracks, PlayerResource:GetPlayer(iPlayerID)) 
	 	ParticleManager:SetParticleControl(claimParticle, 0, particlePosition - Vector(50,0,0))



		
		AddUnitToSelection(barracks)
		UTIL_Remove(event.caster)


	end
end


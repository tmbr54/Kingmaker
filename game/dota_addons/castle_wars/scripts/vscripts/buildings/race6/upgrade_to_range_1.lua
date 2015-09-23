--Undead Range Spawner
function cast_upgrade(event)
	local iPlayerID = event.caster:GetMainControllingPlayer()
	--print("iPlayerID", iPlayerID)
	local hero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
	--print("hero name: ",PlayerResource:GetSelectedHeroName(iPlayerID))
	
	local iTeamNumber = hero:GetTeamNumber()
	local vPosition = event.caster:GetAbsOrigin()


	if RemoveGold(iPlayerID, 50, 7) == true then
		local barracks = CreateUnitByName("race_6_range_building_1", vPosition, false, hero, hero, iTeamNumber)
		barracks:SetControllableByPlayer(iPlayerID, true)


		local particlePosition = barracks:GetAbsOrigin()
		local upgradeParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_quill_spray_ring_dust.vpcf", PATTACH_ABSORIGIN_FOLLOW, barracks)
		ParticleManager:SetParticleControl(upgradeParticle, 0, barracks:GetAbsOrigin())
	 	local claimParticle = ParticleManager:CreateParticleForPlayer("particles/econ/courier/courier_baekho/courier_baekho_ambient.vpcf", PATTACH_OVERHEAD_FOLLOW, barracks, PlayerResource:GetPlayer(iPlayerID)) 
	 	ParticleManager:SetParticleControl(claimParticle, 0, particlePosition - Vector(50,0,0))
	 	currentTeam = barracks:GetTeam()
	 	ParticleManager:SetParticleControl(claimParticle, 15, race_color_table[currentTeam])
	 	


		UTIL_Remove(event.caster)
		AddUnitToSelection(barracks)

	end
end


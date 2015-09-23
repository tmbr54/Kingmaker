
-- Creates a DOTA unit by its dota_npc_units.txt name ( szUnitName, vLocation, bFindClearSpace, hNPCOwner, hUnitOwner, iTeamNumber )
function spawn_unit(event)
	local iPlayerID = event.caster:GetMainControllingPlayer()
	--print("iPlayerID", iPlayerID)
	local hero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
	--print("hero name: ",PlayerResource:GetSelectedHeroName(iPlayerID))
	local iFoodPerSpawn = 2
	local iTeamNumber = hero:GetTeamNumber()
	local currentPop = GetPopulationNumber(iTeamNumber)
	local rallyPoint = rallyPointPerUnitTable[event.caster:GetEntityIndex()]
	
	if RemoveGold(iPlayerID, 5, 7) == true then
		if currentPop + iFoodPerSpawn <= populationLimit then
			local spawned_unit = CreateUnitByName("race_2_range_tier_1_mortar", event.caster:GetAbsOrigin(), true, hero, hero, iTeamNumber)
			spawned_unit:SetControllableByPlayer(iPlayerID, true)
			FindClearSpaceForUnit(spawned_unit, event.caster:GetAbsOrigin(), true)
			AddToPopulation(iTeamNumber, iFoodPerSpawn)
			MoveToRallyPoint(spawned_unit, rallyPoint)

			
			particlePosition = event.caster:GetAbsOrigin()
			local timerParticle = ParticleManager:CreateParticleForPlayer("particles/clock_circle.vpcf", PATTACH_OVERHEAD_FOLLOW, event.caster, PlayerResource:GetPlayer(iPlayerID)) 
			ParticleManager:SetParticleControl(timerParticle, 0, particlePosition - Vector(50,0,0))
			ParticleManager:SetParticleControl(timerParticle, 10, Vector(0.96, 0.96, 0.83))

			local interval = 1.0
			Timers:CreateTimer( function() 
				if event.ability:GetToggleState() == false then
					ParticleManager:DestroyParticle(timerParticle, true)
					interval = nil
				end

				return interval
				end)

		else
			event.ability:ToggleAbility()
			print("pop limit reached")
			
		end
	end
end

--Human Footman
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

	if RemoveGold(iPlayerID, 6, 7) == true then
		if currentPop + iFoodPerSpawn <= populationLimit then
			local spawned_unit = CreateUnitByName("race_8_melee_tier_2_footman", event.caster:GetAbsOrigin(), true, hero, hero, iTeamNumber)
			spawned_unit:SetControllableByPlayer(iPlayerID, true)
			--print("su_id", spawned_unit:GetPlayerOwnerID())
			FindClearSpaceForUnit(spawned_unit, event.caster:GetAbsOrigin(), true)
			AddToPopulation(iTeamNumber, iFoodPerSpawn)
			MoveToRallyPoint(spawned_unit, rallyPoint)			
									particlePosition = event.caster:GetAbsOrigin()
			local timerParticle = ParticleManager:CreateParticleForPlayer("particles/clock_circle.vpcf", PATTACH_OVERHEAD_FOLLOW, event.caster, PlayerResource:GetPlayer(iPlayerID)) 
			ParticleManager:SetParticleControl(timerParticle, 0, particlePosition - Vector(50,0,0))
			ParticleManager:SetParticleControl(timerParticle, 10, Vector(0.32, 0.65, 0.36))

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

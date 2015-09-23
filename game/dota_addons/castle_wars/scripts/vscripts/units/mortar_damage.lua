function damage( events )
	

	local attacker_damage = events.caster:GetAttackDamage()
	
	
	local found_units = Entities:FindAllInSphere(events.target:GetAbsOrigin(), 200.0)
	--PrintTable(found_units)
	for number,target in pairs(found_units) do

		if (target.IsHero and target:IsHero()) or (target.IsCreature and target:IsCreature()) then
			local damage_table = {}

			local damage_mult = events.ability:GetLevelSpecialValueFor( "damage_reduction" , events.ability:GetLevel() - 1  )
			damage_table.attacker = events.caster
			damage_table.victim = target
			damage_table.ability = events.ability
			damage_table.damage = attacker_damage * (damage_mult / 100)
			damage_table.damage_type = DAMAGE_TYPE_PHYSICAL
			--PrintTable(damage_table)
			if damage_table.victim ~= events.target and damage_table.victim:GetTeam() ~= events.caster:GetTeam() then
				
				ApplyDamage(damage_table)
				local hitParticle = ParticleManager:CreateParticle("particles/mortar_particle/mortar_explosion.vpcf", PATTACH_ABSORIGIN, damage_table.victim)
				ParticleManager:SetParticleControl(hitParticle, 0, damage_table.victim:GetAbsOrigin() + Vector(0,0,80))
				ParticleManager:SetParticleControl(hitParticle, 1, damage_table.victim:GetAbsOrigin() + Vector(0,0,80))
				ParticleManager:SetParticleControl(hitParticle, 3, damage_table.victim:GetAbsOrigin() + Vector(0,0,80))
				ParticleManager:SetParticleControl(hitParticle, 7, damage_table.victim:GetAbsOrigin() + Vector(0,0,80))
				--print("Damage has been dealt to ", damage_table.victim:GetUnitName())
			end
		end
	end
end
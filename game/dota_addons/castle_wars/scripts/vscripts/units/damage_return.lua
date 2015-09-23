function ability( event )
    -- Variables
    local caster = event.caster
    local attacker = event.attacker
    local ability = event.ability
    local damage = ability:GetLevelSpecialValueFor( "return_damage" , ability:GetLevel() - 1  ) 
    local return_damage = damage

    -- Damage
    if attacker:IsRangedAttacker() ~= true then
    	ApplyDamage({ victim = attacker, attacker = caster, damage = return_damage, damage_type = DAMAGE_TYPE_PURE })
    	local hitParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit_spikes.vpcf", PATTACH_ABSORIGIN_FOLLOW, attacker)
    	ParticleManager:SetParticleControl(hitParticle, 0, attacker:GetAbsOrigin() + Vector(0,0,80))

    	print("done "..return_damage)
    end
end
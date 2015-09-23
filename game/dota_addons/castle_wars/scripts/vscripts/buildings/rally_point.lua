function MoveToRallyPoint( event )
    local caster = event.caster
    local target = event.target

    -- Change this to your desired Vector, usually as an hscript:GetAbsOrigin()
    

    ExecuteOrderFromTable({ UnitIndex = target:GetEntityIndex(), 
                            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                            Position = position, Queue = true })
    print(target:GetUnitName().." moving to position",position)

    local player = caster:GetPlayerOwner()
    local hero = player:GetAssignedHero()
    target:SetOwner(hero)


end
function OnEndTouch(event)

	local unit = event.activator
	local teamID = unit:GetTeamNumber()
	local unitPopValue = GetUnitPopulationValue(unit)
	
	
	unitOutsideBaseTable[teamID] = unitOutsideBaseTable[teamID] - unitPopValue
	if unitOutsideBaseTable[teamID] <= 0 then
		unitOutsideBaseTable[teamID] = 0
    print("OnEndTouch: unitOutsideBaseTable ".. teamID .. " : " .. unitOutsideBaseTable[teamID])

	end


end




	



function OnStartTouch(event)

	local unit = event.activator
	local teamID = unit:GetTeamNumber()
	local unitPopValue = GetUnitPopulationValue(unit)
	unitOutsideBaseTable[teamID] = unitOutsideBaseTable[teamID] + unitPopValue
  

	print("OnStartTouch: unitOutsideBaseTable ".. teamID .. " : " .. unitOutsideBaseTable[teamID])


end


function GetUnitPopulationValue(unit)
  local pop = 0
  if unit:HasModifier("has_population_1") then
    --print("Killed unit had a Population of 1")
    pop = pop + 1  
  end
  if unit:HasModifier("has_population_2") then
    --print("Killed unit had a Population of 2")
    pop = pop + 2
  end
  if unit:HasModifier("has_population_3") then
    --print("Killed unit had a Population of 2")
    pop = pop + 3
  end  
  if unit:HasModifier("has_population_5") then 
    --print("Killed unit had a Population of 5")
    pop = pop + 5
  end
  if unit:HasModifier("has_population_10") then
    --print("Killed unit had a Population of 10")
    pop = pop + 10
  end
return pop
end
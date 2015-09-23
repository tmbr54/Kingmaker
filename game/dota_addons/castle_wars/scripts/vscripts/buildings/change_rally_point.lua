function change_rally_point(event)
	print(event)
	--[[PrintTable(event)
	unitIndex = event.ability:GetEntityIndex()
	rallyPoint = event.target_points[1]
	print(UnitIndex)
	print(rallyPoint)
	
	--rallyPoint = "test"	
	--[[if table.containsKey(rallyPointPerUnitTable, unitIndex) ~= true then
		print("inserted value ",rallyPoint, "at key ",unitIndex)
		table.insert(rallyPointPerUnitTable, unitIndex, rallyPoint)
	else
		rallyPointPerUnitTable[unitIndex] = rallyPoint
		print("changed value," rallyPoint, "at key", unitIndex)
	end]]
end
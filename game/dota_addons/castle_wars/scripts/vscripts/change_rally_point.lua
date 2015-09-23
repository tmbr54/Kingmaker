function rally_point_change(event)
	unitIndex = event.caster:GetEntityIndex()
	rallyPoint = event.target_points[1]
	if table.containsKey(rallyPointPerUnitTable, unitIndex) ~= true then
		--print("inserted value ",rallyPoint, "at key ",unitIndex)
		table.insert(rallyPointPerUnitTable, unitIndex, rallyPoint)
	else
		rallyPointPerUnitTable[unitIndex] = rallyPoint
		--print("changed value ", rallyPoint, "at key", unitIndex)
	end
end


local folder = script.Parent

local function connectPart(part)
	part.Touched:Connect(function()

		local parts = workspace:GetPartBoundsInRadius(part.Position, 10)

		for _, obj in pairs(parts) do
			if obj:IsA("BasePart") and obj.Name ~= "Baseplate" and obj.Name ~= "BasePlate" then
				obj.Anchored = false
				obj:BreakJoints()
			end
		end

		local explosion = Instance.new("Explosion")
		explosion.Position = part.Position
		explosion.BlastRadius = 100
		explosion.BlastPressure = 500000
		explosion.DestroyJointRadiusPercent = 70
		explosion.Parent = workspace

		part:Destroy()
	end)
end

for _, part in pairs(folder:GetChildren()) do
	if part:IsA("BasePart") then
		connectPart(part)
	end
end
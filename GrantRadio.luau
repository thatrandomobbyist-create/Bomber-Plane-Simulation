local Players = game:GetService("Players")
local tool = game:GetService("ServerStorage").Radio

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local backpack = player:WaitForChild("Backpack")
		local toolC = tool:Clone()
		toolC.Parent = backpack
	end)
end)

local DropBombEvent = game:GetService("ReplicatedStorage").RemoteEvents.DropBomb
local nuke = workspace.Bombs
local NukePlane = workspace.NukePlane
local TemplateNuke = workspace.TemplateNuke
local TweenService = game:GetService("TweenService")

DropBombEvent.OnServerEvent:Connect(function(Player, Pos)
	NukePlane:PivotTo(CFrame.new(Pos + Vector3.new(-500, 200, 0)))
	
	
	local startCFrame = NukePlane:GetPivot()
	local endCframe = CFrame.new(Pos + Vector3.new(500, 200, 0))
	
	local CframeVal = Instance.new("CFrameValue")
	CframeVal.Value = startCFrame
	
	CframeVal:GetPropertyChangedSignal("Value"):Connect(function()
		NukePlane:PivotTo(CframeVal.Value)
	end)
	
	local tween = TweenService:Create(CframeVal, TweenInfo.new(10), {Value = endCframe})
	tween:Play()
	
	task.wait(2.5)

	
	for _, obj in pairs(nuke:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.CFrame = CFrame.new(Vector3.new(Pos.X + math.random(-10, 10), Pos.Y + 150, Pos.Z + math.random(-10, 10)))
			obj.Anchored = false
			wait(0.2)
		end
	end
	for i = 1, 3 do
		local NukeC  = TemplateNuke:Clone()
		NukeC.Parent = nuke
	end
end)

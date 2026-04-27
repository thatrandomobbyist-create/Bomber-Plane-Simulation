local tool = script.Parent
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local jetPos = workspace.JetPos
local jetLookAt = workspace.JetLookAt

local PlayerGUI = player.PlayerGui
local BombRadius = PlayerGUI:WaitForChild("ScreenGui"):WaitForChild("BombRadius")

local UserInput = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local HeartBeatConnection
local UserInputConnection

local DropBombEvent = game:GetService("ReplicatedStorage").RemoteEvents.DropBomb

tool.Activated:Connect(function()
	
	jetPos.Position = hrp.Position + Vector3.new(0, 500, 0)
	jetLookAt.Position = hrp.Position - Vector3.new(0, 2, 0)
	
	
	if HeartBeatConnection then
		HeartBeatConnection:Disconnect()
	end

	if UserInputConnection then
		UserInputConnection:Disconnect()
	end
	
	local originalType = camera.CameraType
	local originalSubject = camera.CameraSubject
	
	camera.CameraType = Enum.CameraType.Scriptable
	
	local targetPos = jetPos.Position
	local LookAtPos = jetLookAt.Position
	
	camera.CFrame = CFrame.new(targetPos, LookAtPos)
	
	HeartBeatConnection = RunService.Heartbeat:Connect(function(DT)
		BombRadius.AnchorPoint = Vector2.new(0.5, 0.75)
		BombRadius.BackgroundTransparency = 0.5
		local MousePos = UserInput:GetMouseLocation()
		BombRadius.Position = UDim2.fromOffset(MousePos.X, MousePos.Y)
	end)
	UserInputConnection = UserInput.InputBegan:Connect(function(InputObj, GameProcessed)
		if GameProcessed then return end
	
		
		if InputObj.UserInputType == Enum.UserInputType.MouseButton2 then
			BombRadius.BackgroundTransparency = 1
			
			local mousePos = UserInput:GetMouseLocation()

			-- Create a ray from the camera through the mouse
			local ray = camera:ViewportPointToRay(mousePos.X, mousePos.Y)

			-- Raycast settings
			local raycastParams = RaycastParams.new()
			raycastParams.FilterDescendantsInstances = {player.Character}
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude

			local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)

			if result then
				DropBombEvent:FireServer(result.Position)
			end
			
			if HeartBeatConnection then
				HeartBeatConnection:Disconnect()
			end
			if UserInputConnection then
				UserInputConnection:Disconnect()
			end
			camera.CameraType = originalType
			camera.CameraSubject = originalSubject
		end
	end)
end)

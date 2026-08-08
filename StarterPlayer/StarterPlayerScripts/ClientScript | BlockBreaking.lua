local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local uis = game:GetService("UserInputService")

local savedChunkData = game.ReplicatedStorage.SavedClientData.ChunkData

local db = false
uis.InputBegan:Connect(function(input, proc)
	if proc then return end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 and not db then
		
		db = true
		
		--Destroy block if it is a player placed block
		if mouse.Target ~= nil and mouse.Target:IsA("BasePart") then
			
			if mouse.Target:HasTag("PlayerPlaced") then
				
				game.ReplicatedStorage.Events.DestroyPlayerPlacedBlock:FireServer(mouse.Target)
			else
				mouse.Target:Destroy()
				if mouse.Target ~= nil and mouse.Target.Parent.Name == "Chunk" then
					
					for _, chunk:Model in savedChunkData:GetChildren() do
						if chunk:GetAttribute("ChunkPos") == mouse.Target.Parent:GetAttribute("ChunkPos") then
							chunk:Destroy()
						end
					end
					
					mouse.Target.Parent:Clone().Parent = savedChunkData
				end
			end
		end
		task.wait(1)
		db = false
		
	end
end)

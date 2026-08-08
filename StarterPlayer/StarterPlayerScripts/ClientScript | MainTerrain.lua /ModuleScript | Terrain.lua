local Terrain = {
	["maxDistance"] = 4
}

local chunkMod = require(script.ChunkModule)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local debugUI = plr.PlayerGui:WaitForChild("DebugUI")

plr.CharacterAdded:Connect(function(newChar)
	char = newChar
	print("added")
end)

local BlockFolder = Instance.new("Folder", workspace)
BlockFolder.Name = "Blocks"

function  Terrain.ChunkGenerationLoop()
	while task.wait(1) do
		if not char:FindFirstChild("HumanoidRootPart") then continue end
		local xChunkPOS = math.floor(char:WaitForChild("HumanoidRootPart", 4).Position.X / 64)
		local zChunkPOS = math.floor(char:WaitForChild("HumanoidRootPart", 4).Position.Z / 64)

		char:SetAttribute("ChunkPos", Vector2.new(xChunkPOS, zChunkPOS))
		--debugUI.Positions["Chunk Position"].Text = "Chunk Position: X: ".. tostring(xChunkPOS).. ", Z: "..tostring(zChunkPOS)
		--debugUI.Positions["Roblox Position"].Text = "Roblox Position: X: ".. tostring(math.round(char.HumanoidRootPart.Position.X)).. ", Y: "..tostring(math.round(char.HumanoidRootPart.Position.Y)) .. ", Z: "..tostring(math.round(char.HumanoidRootPart.Position.Z))
		--debugUI.Positions["Block Position"].Text = "Block Position: X: ".. tostring(math.floor(char.HumanoidRootPart.Position.X / 8)).. ", Y: "..tostring(math.floor(char.HumanoidRootPart.Position.Y / 8)) .. ", Z: "..tostring(math.floor(char.HumanoidRootPart.Position.Z / 8))


		for i = -Terrain.maxDistance, Terrain.maxDistance do
			for j = -Terrain.maxDistance, Terrain.maxDistance do
				local Currentdistance = (Vector2.new(xChunkPOS + i, zChunkPOS + j) - char:GetAttribute("ChunkPos")).Magnitude
				if Currentdistance <= Terrain.maxDistance then
					chunkMod.GenerateChunk(xChunkPOS + i, zChunkPOS + j, BlockFolder)
				end
			end
		end

		for _, v in BlockFolder:GetChildren() do
			local distance = (v:GetAttribute("ChunkPos") - char:GetAttribute("ChunkPos")).Magnitude


			if math.random(1, 20) == 1 then
				task.wait(0.2)
			end
			if distance > Terrain.maxDistance then --and v:GetAttribute("ShouldDelete")
				v:Destroy()
			end

		end
	end
end

return Terrain

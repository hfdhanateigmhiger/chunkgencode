local ChunkModule = {}

local Seed = script.Parent.Parent.Seed.Value
local NatureModule = require(script.Parent.Nature)
local savedChunkData = game.ReplicatedStorage.SavedClientData.ChunkData

local blockHeightChunk = 10

function ChunkModule.GenerateChunk(ChunkX, ChunkZ, ChunksParent)
	-- Don't generate the chunk if there's already one at this position
	for _, v in ChunksParent:GetChildren() do
		if v:GetAttribute("ChunkPos") == Vector2.new(ChunkX, ChunkZ) then
			for _, block in v:GetChildren() do
				block.Transparency = 0
			end
			return
		end
	end
	
	for _, v in savedChunkData:GetChildren() do
		if v:GetAttribute("ChunkPos") == Vector2.new(ChunkX, ChunkZ) then
			v:Clone().Parent = ChunksParent
			return
		end
	end

	-- Generate Chunk
	task.spawn(function()
		local Chunk = Instance.new("Model", ChunksParent)
		Chunk.Name = "Chunk"
		Chunk:SetAttribute("ChunkPos", Vector2.new(ChunkX, ChunkZ))

		for x = 1, 16 do
			for z = 1, 16 do



				-- Generate noise-based height for the block
				local worldX = (x + ChunkX * 16)
				local worldZ = (z + ChunkZ * 16)
				local HillNoise = math.noise(worldX / 200, worldZ / 200, Seed) * 80

				if HillNoise < -15 then
					HillNoise = 20
				elseif HillNoise <  5 then
					HillNoise = 35
				elseif  math.round(HillNoise) == 0 then
					HillNoise = 45
				elseif HillNoise > 5 then
					HillNoise = 100
				else
					HillNoise = 80
				end


				local BlockNoiseHeight = math.noise(worldX / 50, worldZ / 50, Seed) * HillNoise
				local TreeNoise = math.noise(worldX / 1000, worldZ / 1000, Seed) * BlockNoiseHeight

				task.spawn(function()
					for y=1, blockHeightChunk do
						local blockX = (x * 4) + (ChunkX * 64) - 0
						local blockZ = (z * 4) + (ChunkZ * 64) - 0
						local block = Instance.new("Part", Chunk)
						block.Anchored = true
						block.CastShadow = false
						block.Name = "Block"
						block.Material = Enum.Material.Grass
						block.Color = Color3.fromRGB(0, 255, 0)
						block.Size = Vector3.new(4, 4, 4)
						block.Position = Vector3.new(
							blockX,
							math.floor(BlockNoiseHeight / 4) * 4 + (y*4), -- Rounded height
							blockZ
						)
						if TreeNoise >= 1 and y == blockHeightChunk and math.random(1, 10) == 1 then
							local TreeY = math.floor(BlockNoiseHeight / 4) * 4 + (y*4)
							NatureModule.GenerateTree(Vector3.new(blockX, TreeY, blockZ), "Oak", Chunk)
						end

						-- Add a delay to prevent lag during chunk generation
						task.wait(0.1)
					end
				end)

				if math.random(1, 50) == 1 then
					task.wait()
				end
				


			end
		end
	end)
end

return ChunkModule

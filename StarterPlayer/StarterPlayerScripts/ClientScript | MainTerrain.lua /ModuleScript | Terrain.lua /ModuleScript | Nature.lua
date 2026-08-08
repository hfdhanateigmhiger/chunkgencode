local Nature = {
	["Trees"] = {
		["TreeTypes"] = {
			["Oak"] = {
				["Name"] = "Oak",
				["TreeHeight"] = 4,
				["Wood"] = {
					Material = Enum.Material.Wood,
					Color = Color3.fromRGB(102, 79, 22),
					Transparency = 0
				}
			}
		}
	}
}

function Nature.GenerateTree(TreePos:Vector3, TreeType:string, ChunkInstance:Model)
	for _, TYPE in Nature.Trees.TreeTypes do
		if TreeType == TYPE.Name then
			--Begin Generating the tree
			for height=1, TYPE.TreeHeight do
				local WoodPart = Instance.new("Part")
				WoodPart.Position = TreePos + Vector3.new(0, height * 4, 0)
				WoodPart.Anchored = true
				WoodPart.Color = TYPE.Wood.Color
				WoodPart.Transparency = TYPE.Wood.Transparency
				WoodPart.Material = TYPE.Wood.Material
				WoodPart.Parent = ChunkInstance
				WoodPart.Size = Vector3.new(4, 4, 4)
			end
			
		end
	end
end

return Nature

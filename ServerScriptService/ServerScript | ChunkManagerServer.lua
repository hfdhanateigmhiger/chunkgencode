local events = game.ReplicatedStorage.Events

events.StoreUpdatedChunkInServer.OnServerEvent:Connect(function(plr:Player, chunk:SharedTable)
	print(chunk)
	print("GOT HERE")

	if chunk[1] == nil then return end
	print(chunk)
	chunk[1]:Clone().Parent = game.ServerStorage.ServerChunks
end)

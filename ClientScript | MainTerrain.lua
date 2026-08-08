local seedEvent = game.ReplicatedStorage.Events.ServerToClient.ChangeSeed
local plr = game.Players.LocalPlayer
local ping = plr:GetNetworkPing()

seedEvent.OnClientEvent:Once(function(seed)
	
	script.Seed.Value = seed
	
	script.Seed.Changed:Connect(function()
		game.Players.LocalPlayer:Kick("Some kind of cheat detected. Seed was changed.")
		script.Seed.Value = 0
	end)
	
	local Terrain = require(script.Terrain)
	task.spawn(Terrain.ChunkGenerationLoop)
end)

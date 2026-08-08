local WorldSeed = math.random(-132, 1000)
local Players = game.Players

Players.PlayerAdded:Connect(function(plr:Player)
	task.spawn(function()
		plr.CharacterAdded:Wait()
		game.ReplicatedStorage.Events.ServerToClient.ChangeSeed:FireClient(plr, WorldSeed)
	end)
end)

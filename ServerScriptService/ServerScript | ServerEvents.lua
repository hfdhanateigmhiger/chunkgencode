local RS = game:GetService("ReplicatedStorage")
local events = RS:WaitForChild("Events")

events.DestroyPlayerPlacedBlock.OnServerEvent:Connect(function(plr, block:BasePart)
	if block == nil or not block:IsA("BasePart") then return end
	block:Destroy()
end)

if not game:IsLoaded() then
    repeat
        game.Loaded:Wait()
    until game:IsLoaded()
end

local vu = game:GetService("VirtualUser")

Plr = game.Players.LocalPlayer
local function getFRUIT()
    local dist, thing = math.huge
    for i, v in next, game:GetService("Workspace"):GetChildren() do
        if v:IsA("Tool")  then
            local mag =
                (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Handle.Position).magnitude
            if mag < dist then
                dist = mag
                thing = v
            end
        end
    end
    return thing
end


local function getCHEST()
    local dist, thing = math.huge
    for i, v in next, game:GetService("Workspace"):GetChildren() do
        if v:IsA("Model") and v.Name == "Chest" then
            local mag =
                (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Hitbox.Position).magnitude
            if mag < dist then
                dist = mag
                thing = v
            end
        end
    end
    return thing
end
local TweenService = game:GetService("TweenService")
local noclipE = false
local antifall = false

local function noclip()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide == true then
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

local function moveto(obj, speed)
    local info =
        TweenInfo.new(
        ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - obj.Position).Magnitude) / speed,
        Enum.EasingStyle.Linear
    )
    local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = obj})

    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
        antifall = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
        antifall.Velocity = Vector3.new(0, 0, 0)
        noclipE = game:GetService("RunService").Stepped:Connect(noclip)
        tween:Play()
    end

    tween.Completed:Connect(
        function()
            antifall:Destroy()
            noclipE:Disconnect()
        end
    )
end

local MOB = {}

for i, v in pairs(game:GetService("Workspace")["NPC Zones"]:GetDescendants()) do
    if v:IsA "StringValue" and v.Name == "NPCName" then
		if not table.find(MOB, tostring(v.Value)) then
            table.insert(MOB, tostring(v.Value))
        end
    end
end
local ISLAND = {}

for i, v in pairs(game:GetService("Workspace")["Npc_Workspace"]["Spawn Setters"]:GetChildren()) do
    if v:IsA "Model" then
		if not table.find(ISLAND, tostring(v)) then
            table.insert(ISLAND, tostring(v))
        end
    end
end

local BACK = {}

for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA "Tool" then
		if not table.find(BACK, tostring(v)) then
            table.insert(BACK, tostring(v))
        end
    end
end

function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    function Teleport() 
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()
getgenv().SecureMode = true

local Window = Rayfield:CreateWindow({
	Name = "Solar Hub [ V2 ]",
	LoadingTitle = "Solar Hub",
	LoadingSubtitle = "by yPolar",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, 
		FileName = "Project New World"
	},
        Discord = {
        	Enabled = true,
        	Invite = "aZWuYejJgu", 
        	RememberJoins = true
        },

})

local Tab = Window:CreateTab("Main")

local Section = Tab:CreateSection("Farm")


Tab:CreateToggle({
	Name = "Auto click",
	CurrentValue = false,
	Flag = "Toggle8", 
	Callback = function(Value)
		aaaaa = Value
            while aaaaa do task.wait()
                vu:Button1Down(Vector2.new(1000, 1000), workspace.CurrentCamera.CFrame)
                wait(0.1)
                vu:Button1Up(Vector2.new(1000, 1000), workspace.CurrentCamera.CFrame)
		end
	end,
})

Tab:CreateToggle({
	Name = "Mob aura",
	CurrentValue = false,
	Flag = "Toggle3", 
	Callback = function(Value)
		a = Value
            while a do task.wait()
                pcall(function()
                game:GetService("Players").LocalPlayer.Character.Combat.Punch:FireServer((1))
            end)
		end
	end,
})
Tab:CreateLabel("Equip combat! ^^^")

local function getClosest()
    local dist, thing = math.huge
    for i, v in next, game:GetService("Workspace")["NPC Zones"]:GetDescendants() do
        if v:IsA("Model") and v.Parent.Name == "NPCS" and v.NPCName.Value == mob then
            local mag =
                (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
            if mag < dist then
                dist = mag
                thing = v
            end
        end
    end
    return thing
end

Tab:CreateToggle({
	Name = "Farm Mob",
	CurrentValue = false,
	Flag = "Toggle1", 
	Callback = function(Value)
        aa = Value
        while aa do task.wait()
            pcall(function()
                moveto(getClosest().HumanoidRootPart.CFrame + Vector3.new(0,0,0),200)
                if mob == "Thief" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("1"):FindFirstChild("1"),
                        [2] = "Level 1"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Bandit" then
                local args = {
                    [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("1"):FindFirstChild("1"),
                    [2] = "Level 10"
                }

                game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Bandit Boss" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("1"):FindFirstChild("1"),
                        [2] = "Level 25"
                    }
    
                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Pirate Clown" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("2"):FindFirstChild("2"),
                        [2] = "Level 40"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Clown Boss" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("2"):FindFirstChild("2"),
                        [2] = "Level 60"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Fishman" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("3"):FindFirstChild("3"),
                        [2] = "Level 90"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Shark Boss" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("3"):FindFirstChild("3"),
                        [2] = "Level 120"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Desert Thief" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("4"):FindFirstChild("4"),
                        [2] = "Level 160"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Bomb Boss" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("4"):FindFirstChild("4"),
                        [2] = "Level 200"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Krieg Pirate" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("5"):FindFirstChild("5"),
                        [2] = "Level 250"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Krieg Boss" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("5"):FindFirstChild("5"),
                        [2] = "Level 300"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Marine Recruit" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("6"):FindFirstChild("6"),
                        [2] = "Level 350"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Tashii" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("6"):FindFirstChild("6"),
                        [2] = "Level 400"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Monkey" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("7"):FindFirstChild("7"),
                        [2] = "Level 450"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Gorilla" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("7"):FindFirstChild("7"),
                        [2] = "Level 500"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "King Gorilla" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("7"):FindFirstChild("7"),
                        [2] = "Level 550"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Marine Grunt" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("8"):FindFirstChild("8"),
                        [2] = "Level 600"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Marine Captain" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("8"):FindFirstChild("8"),
                        [2] = "Level 650"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Satyr" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("9"):FindFirstChild("9"),
                        [2] = "Level 700"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Minotaur" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("9"):FindFirstChild("9"),
                        [2] = "Level 750"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Elite Marine" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("10"):FindFirstChild("10"),
                        [2] = "Level 800"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Vice Admiral" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("10"):FindFirstChild("10"),
                        [2] = "Level 850"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))
                elseif mob == "Ice Admiral" then
                    local args = {
                        [1] = workspace.Npc_Workspace.QuestGivers:FindFirstChild("10"):FindFirstChild("10"),
                        [2] = "Level 900"
                    }

                    game:GetService("Players").LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(unpack(args))

                end
            end)
        end
	end,
})

local drop = Tab:CreateDropdown({
	Name = "Select Mob",
	Options = MOB,
	CurrentOption = "Mob List",
	Flag = "Dropdown1", 
	Callback = function(Value)
        getgenv().mob = Value
	end,
})

Tab:CreateButton({
	Name = "Refresh mobs",
	Callback = function()
        table.clear(MOB)
        for i, v in pairs(game:GetService("Workspace")["NPC Zones"]:GetDescendants()) do
            if v:IsA "StringValue" and v.Name == "NPCName" then
                if not table.find(MOB, tostring(v.Value)) then
                    table.insert(MOB, tostring(v.Value))
                    drop:Refresh(MOB, "Mob List")
                end
            end
        end
	end,
})

local Tab = Window:CreateTab("TP")
    Tab:CreateDropdown({
	Name = "Select Island",
	Options = ISLAND,
	CurrentOption = "Island List",
	Flag = "Dropdown2", 
	Callback = function(Value)
        getgenv().island = Value
	end,
})

    Tab:CreateDropdown({
	Name = "Select Npc",
	Options = {
    "Buso",
    "ObsHaki",
    "Black Leg",
    "Flashstep 1",
    "Flashstep 2",
    "Pipe",
    "Katana",
    "Soul Cane"},
	CurrentOption = "Npc List",
	Flag = "Dropdown3", 
	Callback = function(Value)
        getgenv().npc = Value
	end,
})
Tab:CreateButton({
	Name = "Teleport to Island",
	Callback = function()
        local args = {
            [1] = island
        }

        game:GetService("ReplicatedStorage").Replication.ClientEvents.SetSpawnPoint:FireServer(unpack(args))
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
	end,
})
Tab:CreateButton({
	Name = "Teleport to Npc",
	Callback = function()
        if npc == "Buso" then
            moveto(game:GetService("Workspace")["Npc_Workspace"].Buso["1"].Clicker.CFrame
            + Vector3.new(0,0,0),200)
        elseif npc == "ObsHaki" then
            moveto(game:GetService("Workspace")["Npc_Workspace"].ObsHaki["1"].Clicker.CFrame + Vector3.new(0,0,0),1000)

        elseif npc == "Black Leg" then
            moveto(game:GetService("Workspace")["Npc_Workspace"].Geppo["Black Leg"].Clicker.CFrame + Vector3.new(0,0,0),1000)


        elseif npc == "Flashstep 1" then
            moveto(game:GetService("Workspace")["Npc_Workspace"].FlashStep["1"].Clicker.CFrame + Vector3.new(0,0,0),1000)

        elseif npc == "Flashstep 2" then
            moveto(game:GetService("Workspace")["Npc_Workspace"].FlashStep["2"].Clicker.CFrame + Vector3.new(0,0,0),1000)

        elseif npc == "Pipe" then
            moveto(game:GetService("Workspace")["Npc_Workspace"]["Sword Sellers"].Pipe.Clicker.CFrame + Vector3.new(0,0,0),1000)

        elseif npc == "Katana" then
            moveto(game:GetService("Workspace")["Npc_Workspace"]["Sword Sellers"].Katana.Clicker.CFrame + Vector3.new(0,0,0),1000)

        elseif npc == "Soul Cane" then
            moveto(game:GetService("Workspace")["Npc_Workspace"]["Sword Sellers"]["Soul Cane"].Clicker.CFrame + Vector3.new(0,0,0),1000)
            
        end
	end,
})
Tab:CreateButton({
	Name = "Hop Server",
	Callback = function()
	Hop()
   end
})

    Tab = Window:CreateTab("Others")

    Tab:CreateLabel("Farm Configs")
    WEAP = Tab:CreateDropdown({
	Name = "Select Weapon",
	Options = BACK,
	CurrentOption = "Weapon List",
	Flag = "Dropdown4", 
	Callback = function(Value)
        getgenv().weapon = Value
	end,
})

Tab:CreateButton({
	Name = "Refresh Weapons",
	Callback = function()
        table.clear(BACK)
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA "Tool" then
                if not table.find(BACK, tostring(v)) then
                    table.insert(BACK, tostring(v))
                    WEAP:Refresh(BACK, "Weapon List")
                end
            end
        end
	end,
})

Tab:CreateToggle({
	Name = "Auto Equip",
	CurrentValue = false,
	Flag = "Toggle5", 
	Callback = function(Value)
        aaa = Value
        while aaa do task.wait()
            pcall(function()
                if Plr.Backpack:FindFirstChild(weapon) and Plr.Character:FindFirstChild(weapon) == nil then
                    local tool = Plr.Backpack:FindFirstChild(weapon)
                    Plr.Character.Humanoid:EquipTool(tool)      
                    task.wait(5)   
                end
            end)
        end
	end,
})

Tab:CreateLabel("Stats Configs")
    Tab:CreateDropdown({
	Name = "Select Stats",
	Options = {"Combat",
    "Defense",
    "Sword",
    "Fruit"},
	CurrentOption = "Stats List",
	Flag = "Dropdown6", 
	Callback = function(Value)
        getgenv().stat = Value
	end,
})


Tab:CreateToggle({
	Name = "Auto Stats",
	CurrentValue = false,
	Flag = "Toggle5", 
	Callback = function(Value)
        getgenv().aaaaaaa = Value
        aaaaaaa = Value
        while aaaaaaa do task.wait()
            local args = {
                [1] = stat,
                [2] = 1
            }
            game:GetService("ReplicatedStorage").Replication.ClientEvents.Stats_Event:FireServer(unpack(args))
        end
	end,
})

Tab:CreateLabel("Mics Config")

Tab:CreateToggle({
	Name = "Chests Sniper",
	CurrentValue = false,
	Flag = "Toggle1", 
	Callback = function(Value)
        getgenv().aaaa = Value
        aaaa = Value
        while aaaa do task.wait()
            pcall(function()
                moveto(getCHEST().Hitbox.CFrame + Vector3.new(0,0,0),500)
            end)
        end
	end,
})
Tab:CreateToggle({
	Name = "Devil Fruit Sniper",
	CurrentValue = false,
	Flag = "Toggle1", 
	Callback = function(Value)
        getgenv().aaaa = Value
        aaaa = Value
        while aaaa do task.wait()
            pcall(function()
                moveto(getFRUIT().Handle.CFrame + Vector3.new(0,0,0),1000)
                for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        if game:GetService("Players").LocalPlayer:DistanceFromCharacter(v.Position) <= 50 then
                            if v:FindFirstChild("ProximityPrompt") then
                                fireproximityprompt(v.ProximityPrompt)
                            end
                        end
                    end
                end
            end)
        end
	end,
})
Tab:CreateToggle({
	Name = "Devil Fruit Notifier",
	CurrentValue = false,
	Flag = "Toggle4", 
	Callback = function(Value)
        getgenv().b = Value
        b = Value
        while b do task.wait()
            for i, v in next, game:GetService("Workspace"):GetChildren() do
                    if v:IsA("Tool") then
                        Rayfield:Notify({
                            Title = "Devil Fruit Found",
                            Content = v.Name .. "has been found",
                            Duration = 6.5,
                            Image = 4483362458,
                            Actions = { -- Notification Buttons
                                Ignore = {
                                    Name = "Okay!",
                                    Callback = function()
                                        print("The user tapped Okay!")
                                    end
                                },
                            },
                        })
                        task.wait(20)
                end
            end
        end
	end,
})

Tab:CreateButton({
	Name = "Redeem all codes",
	Callback = function()
        local args = 
        {
           [1] = "20KLIKESCOOL"
        }
        game:GetService("ReplicatedStorage").Replication.ClientEvents.ClaimCode:InvokeServer(unpack(args))
        local args = 
        {
           [1] = "RELEASEYT"
        }
        game:GetService("ReplicatedStorage").Replication.ClientEvents.ClaimCode:InvokeServer(unpack(args))

        local GameLoadGui = Instance.new("Message",workspace);
        GameLoadGui.Text = 'All codes updated: 24/12 - yPolar';
        task.wait(10);
        GameLoadGui:Destroy();
    end
})

Rayfield:LoadConfiguration()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function new(cls, props)
	local obj = Instance.new(cls)
	if props then
		for k,v in pairs(props) do
			obj[k] = v
		end
	end
	return obj
end

local function clearExisting()
	for _,g in ipairs(playerGui:GetChildren()) do
		if g.Name == "VortexScripthubGui" or g.Name == "VortexScripthubToggle" or g.Name == "VortexLoadingScreen" then
			g:Destroy()
		end
	end
end

local function createLoadingScreen(callback)
	local loadingGui = new("ScreenGui", { 
		Name = "VortexLoadingScreen", 
		Parent = playerGui, 
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999
	})
	
	local blur = new("BlurEffect", {
		Parent = game:GetService("Lighting"),
		Size = 0
	})
	
	local bg = new("Frame", {
		Parent = loadingGui,
		Size = UDim2.new(1,0,1,0),
		BackgroundColor3 = Color3.fromRGB(10,10,15),
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0
	})
	
	local loadingText = new("TextLabel", {
		Parent = bg,
		Size = UDim2.new(0,600,0,80),
		Position = UDim2.new(0.5,-300,0.5,-40),
		BackgroundTransparency = 1,
		Text = "Vortex ScriptHub Loaded",
		Font = Enum.Font.GothamBold,
		TextSize = 42,
		TextColor3 = Color3.fromRGB(138,43,226),
		TextTransparency = 1,
		TextStrokeTransparency = 0.8,
		TextStrokeColor3 = Color3.fromRGB(75,0,130)
	})
	
	local gradient = new("UIGradient", {
		Parent = loadingText,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(138,43,226)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(186,85,211)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(138,43,226))
		}),
		Offset = Vector2.new(-1,0)
	})
	
	TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 24}):Play()
	
	TweenService:Create(loadingText, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
	
	local gradientTween = TweenService:Create(gradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Offset = Vector2.new(1,0)})
	gradientTween:Play()
	
	wait(2)
	
	TweenService:Create(loadingText, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
	TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0}):Play()
	
	wait(0.5)
	blur:Destroy()
	loadingGui:Destroy()
	
	if callback then callback() end
end

local function createMain()
	clearExisting()
	local screenGui = new("ScreenGui", { Name = "VortexScripthubGui", Parent = playerGui, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
	
	local main = new("Frame", {
		Parent = screenGui,
		Name = "Main",
		Size = UDim2.new(0,480,0,320),
		Position = UDim2.new(0.5,-240,0.5,-160),
		BackgroundColor3 = Color3.fromRGB(20,20,28),
		BorderSizePixel = 0,
	})
	new("UICorner", { Parent = main, CornerRadius = UDim.new(0,16) })
	
	local header = new("Frame", { 
		Parent = main, 
		Size = UDim2.new(1,0,0,56), 
		BackgroundColor3 = Color3.fromRGB(30,30,42),
		BorderSizePixel = 0
	})
	new("UICorner", { Parent = header, CornerRadius = UDim.new(0,16) })
	
	local headerGradient = new("UIGradient", {
		Parent = header,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(75,0,130)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(138,43,226))
		}),
		Rotation = 45
	})
	
	local title = new("TextLabel", {
		Parent = header,
		Position = UDim2.new(0,20,0,0),
		Size = UDim2.new(0.7,0,1,0),
		BackgroundTransparency = 1,
		Text = "⚡ Vortex ScriptHub",
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = Color3.fromRGB(255,255,255),
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	
	local body = new("Frame", { 
		Parent = main, 
		Position = UDim2.new(0,0,0,56), 
		Size = UDim2.new(1,0,1,-56), 
		BackgroundTransparency = 1 
	})

	local left = new("Frame", {
		Parent = body,
		Position = UDim2.new(0,16,0,16),
		Size = UDim2.new(0,140,1,-32),
		BackgroundColor3 = Color3.fromRGB(25,25,35),
		BorderSizePixel = 0,
	})
	new("UICorner", { Parent = left, CornerRadius = UDim.new(0,12) })
	
	local accentLine = new("Frame", {
		Parent = left,
		Size = UDim2.new(0,3,1,0),
		BackgroundColor3 = Color3.fromRGB(138,43,226),
		BorderSizePixel = 0
	})
	new("UICorner", { Parent = accentLine, CornerRadius = UDim.new(0,2) })
	
	local leftLabel = new("TextLabel", {
		Parent = left,
		Position = UDim2.new(0,16,0,12),
		Size = UDim2.new(1,-24,0,24),
		BackgroundTransparency = 1,
		Text = "MENU",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = Color3.fromRGB(138,43,226),
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local gamesScroll = new("ScrollingFrame", {
		Parent = left,
		Position = UDim2.new(0,12,0,44),
		Size = UDim2.new(1,-24,1,-56),
		BackgroundTransparency = 1,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Color3.fromRGB(138,43,226),
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		CanvasSize = UDim2.new(0,0,0,0),
		BorderSizePixel = 0
	})
	local gLayout = new("UIListLayout", { Parent = gamesScroll, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,8) })
	gLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		gamesScroll.CanvasSize = UDim2.new(0,0,0,gLayout.AbsoluteContentSize.Y + 12)
	end)
	
	local right = new("Frame", {
		Parent = body,
		Position = UDim2.new(0,172,0,16),
		Size = UDim2.new(1,-188,1,-32),
		BackgroundColor3 = Color3.fromRGB(25,25,35),
		BorderSizePixel = 0,
	})
	new("UICorner", { Parent = right, CornerRadius = UDim.new(0,12) })
	
	local rightLabel = new("TextLabel", {
		Parent = right,
		Position = UDim2.new(0,16,0,12),
		Size = UDim2.new(1,-32,0,24),
		BackgroundTransparency = 1,
		Text = "SCRIPTS",
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = Color3.fromRGB(138,43,226),
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	
	local scriptsScroll = new("ScrollingFrame", {
		Parent = right,
		Position = UDim2.new(0,16,0,44),
		Size = UDim2.new(1,-32,1,-56),
		BackgroundTransparency = 1,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Color3.fromRGB(138,43,226),
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		CanvasSize = UDim2.new(0,0,0,0),
		BorderSizePixel = 0
	})
	local sLayout = new("UIListLayout", { Parent = scriptsScroll, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,10) })
	sLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		scriptsScroll.CanvasSize = UDim2.new(0,0,0,sLayout.AbsoluteContentSize.Y + 12)
	end)

	local function createBtn(parent, text, height)
		local btn = new("TextButton", {
			Parent = parent,
			Size = UDim2.new(1,0,0,height or 38),
			BackgroundColor3 = Color3.fromRGB(35,35,48),
			Text = "",
			AutoButtonColor = false,
			BorderSizePixel = 0
		})
		new("UICorner", { Parent = btn, CornerRadius = UDim.new(0,10) })
		
		local hoverFrame = new("Frame", {
			Parent = btn,
			Size = UDim2.new(1,0,1,0),
			BackgroundColor3 = Color3.fromRGB(138,43,226),
			BackgroundTransparency = 1,
			BorderSizePixel = 0
		})
		new("UICorner", { Parent = hoverFrame, CornerRadius = UDim.new(0,10) })
		
		local btnText = new("TextLabel", {
			Parent = btn,
			Size = UDim2.new(1,0,1,0),
			BackgroundTransparency = 1,
			Text = text,
			Font = Enum.Font.GothamSemibold,
			TextSize = 13,
			TextColor3 = Color3.fromRGB(220,220,230)
		})
		
		btn.MouseEnter:Connect(function()
			TweenService:Create(hoverFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0.85}):Play()
			TweenService:Create(btnText, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
		end)
		
		btn.MouseLeave:Connect(function()
			TweenService:Create(hoverFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
			TweenService:Create(btnText, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(220,220,230)}):Play()
		end)
		
		return btn
	end

	local function clearScripts()
		for _,c in ipairs(scriptsScroll:GetChildren()) do
			if not c:IsA("UIListLayout") then c:Destroy() end
		end
	end

	local function makeSeparator(parent, titleText)
		local sepFrame = new("Frame", { Parent = parent, Size = UDim2.new(1,0,0,32), BackgroundTransparency = 1 })
		local line = new("Frame", {
			Parent = sepFrame,
			Position = UDim2.new(0,0,0.5,0),
			Size = UDim2.new(1,0,0,1),
			BackgroundColor3 = Color3.fromRGB(50,50,65),
			BorderSizePixel = 0
		})
		local label = new("TextLabel", {
			Parent = sepFrame,
			Size = UDim2.new(0,140,0,32),
			Position = UDim2.new(0.5,-70,0,0),
			BackgroundColor3 = Color3.fromRGB(25,25,35),
			Text = titleText,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = Color3.fromRGB(138,43,226),
			TextXAlignment = Enum.TextXAlignment.Center,
			ZIndex = 2,
		})
		new("UICorner", { Parent = label, CornerRadius = UDim.new(0,8) })
		return sepFrame
	end

	local function showWelcomePage()
		clearScripts()
		
		local welcomeTitle = new("TextLabel", {
			Parent = scriptsScroll,
			Size = UDim2.new(1,0,0,60),
			BackgroundTransparency = 1,
			Text = "Welcome to\nVortex ScriptHub",
			Font = Enum.Font.GothamBold,
			TextSize = 22,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextXAlignment = Enum.TextXAlignment.Center,
		})
		welcomeTitle.LayoutOrder = 1
		
		local welcomeSub = new("TextLabel", {
			Parent = scriptsScroll,
			Size = UDim2.new(1,0,0,40),
			BackgroundTransparency = 1,
			Text = "Select a game from the menu to get started",
			Font = Enum.Font.Gotham,
			TextSize = 14,
			TextColor3 = Color3.fromRGB(200,200,220),
			TextXAlignment = Enum.TextXAlignment.Center,
		})
		welcomeSub.LayoutOrder = 2
		
		local vortexIcon = new("TextLabel", {
			Parent = scriptsScroll,
			Size = UDim2.new(1,0,0,80),
			BackgroundTransparency = 1,
			Text = "⚡",
			Font = Enum.Font.GothamBold,
			TextSize = 48,
			TextColor3 = Color3.fromRGB(138,43,226),
			TextXAlignment = Enum.TextXAlignment.Center,
		})
		vortexIcon.LayoutOrder = 3
		
		local versionText = new("TextLabel", {
			Parent = scriptsScroll,
			Size = UDim2.new(1,0,0,20),
			BackgroundTransparency = 1,
			Text = "Version 1.0",
			Font = Enum.Font.Gotham,
			TextSize = 12,
			TextColor3 = Color3.fromRGB(150,150,170),
			TextXAlignment = Enum.TextXAlignment.Center,
		})
		versionText.LayoutOrder = 4
	end

	local hideBtn = createBtn(gamesScroll, "🎮 Hide or Die", 40)
	hideBtn.LayoutOrder = 1
	hideBtn.MouseButton1Click:Connect(function()
		clearScripts()
		local t = new("TextLabel", {
			Parent = scriptsScroll,
			Size = UDim2.new(1,0,0,28),
			BackgroundTransparency = 1,
			Text = "Hide or Die",
			Font = Enum.Font.GothamBold,
			TextSize = 15,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		t.LayoutOrder = 1
		local vortexBtn = createBtn(scriptsScroll, "Vortex Hide or Die", 42)
		vortexBtn.LayoutOrder = 2
		vortexBtn.MouseButton1Click:Connect(function()
			spawn(function()
				local ok,err = pcall(function()
					loadstring(game:HttpGet('https://raw.githubusercontent.com/VortexBypass/Aimlock/refs/heads/main/main.lua'))()
				end)
				if ok then
					if screenGui and screenGui.Parent then
						screenGui:Destroy()
					end
				else
					local notice = new("TextLabel", {
						Parent = main,
						Size = UDim2.new(0,340,0,32),
						Position = UDim2.new(0.5,-170,1,-44),
						BackgroundColor3 = Color3.fromRGB(220,50,50),
						TextColor3 = Color3.fromRGB(255,255,255),
						Text = "❌ Error: "..tostring(err),
						Font = Enum.Font.GothamBold,
						TextSize = 12,
					})
					new("UICorner", { Parent = notice, CornerRadius = UDim.new(0,10) })
					delay(3, function() if notice and notice.Parent then notice:Destroy() end end)
				end
			end)
		end)
	end)

	local sep = makeSeparator(gamesScroll, "⭐ UNIVERSAL")
	sep.LayoutOrder = 2

	local hitboxMenuBtn = createBtn(gamesScroll, "🎯 Hitbox+ESP", 40)
	hitboxMenuBtn.LayoutOrder = 3
	hitboxMenuBtn.MouseButton1Click:Connect(function()
		clearScripts()
		local pt = new("TextLabel", {
			Parent = scriptsScroll,
			Size = UDim2.new(1,0,0,28),
			BackgroundTransparency = 1,
			Text = "Hitbox + ESP",
			Font = Enum.Font.GothamBold,
			TextSize = 15,
			TextColor3 = Color3.fromRGB(255,255,255),
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		pt.LayoutOrder = 1
		local vortexBtn = createBtn(scriptsScroll, "⚡ Vortex Hitbox+ESP", 42)
		vortexBtn.LayoutOrder = 2
		vortexBtn.MouseButton1Click:Connect(function()
			spawn(function()
				local ok,err = pcall(function()
					loadstring(game:HttpGet('https://raw.githubusercontent.com/VortexBypass/Vortex-HitboxExtender-Esp/refs/heads/main/Hitbox-Esp'))()
				end)
				if ok then
					if screenGui and screenGui.Parent then
						screenGui:Destroy()
					end
				else
					local notice = new("TextLabel", {
						Parent = main,
						Size = UDim2.new(0,340,0,32),
						Position = UDim2.new(0.5,-170,1,-44),
						BackgroundColor3 = Color3.fromRGB(220,50,50),
						TextColor3 = Color3.fromRGB(255,255,255),
						Text = "❌ Failed: "..tostring(err),
						Font = Enum.Font.GothamBold,
						TextSize = 12,
					})
					new("UICorner", { Parent = notice, CornerRadius = UDim.new(0,10) })
					delay(3, function() if notice and notice.Parent then notice:Destroy() end end)
				end
			end)
		end)
	end)

	showWelcomePage()

	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	header.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then update(input) end
	end)
	
	main.Size = UDim2.new(0,0,0,0)
	TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0,480,0,320)}):Play()
end

clearExisting()
createLoadingScreen(function()
	createMain()
end)

local Library = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Features = {
    AutoAimShoot = false,
    ReduceLag = false,
    BoostFPS = false,
    ESP = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Khang6677_Menu"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local function makeDraggable(topbar, object)
    local dragging, dragInput, dragStart, startPos
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = object.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 45)
Topbar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Topbar.BorderSizePixel = 0
Topbar.Parent = MainFrame

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 12)
TopbarCorner.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "khang6677 PREMIUM"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = Topbar

makeDraggable(Topbar, MainFrame)

local HideButton = Instance.new("TextButton")
HideButton.Size = UDim2.new(0, 30, 0, 30)
HideButton.Position = UDim2.new(1, -75, 0.5, -15)
HideButton.Text = "-"
HideButton.TextColor3 = Color3.fromRGB(200, 200, 200)
HideButton.TextSize = 20
HideButton.Font = Enum.Font.GothamBold
HideButton.BackgroundTransparency = 1
HideButton.Parent = Topbar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BackgroundTransparency = 1
CloseButton.Parent = Topbar

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 10, 0.5, -25)
OpenButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
OpenButton.Text = "K"
OpenButton.TextColor3 = Color3.fromRGB(0, 255, 200)
OpenButton.TextSize = 22
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 25)
OpenCorner.Parent = OpenButton

HideButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -65)
ContentFrame.Position = UDim2.new(0, 10, 0, 55)
ContentFrame.BackgroundTransparency = 1
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
ContentFrame.ScrollBarThickness = 2
ContentFrame.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 10)
UIList.Parent = ContentFrame

local function createToggle(name, featureKey, callback)
    local ToggleBg = Instance.new("Frame")
    ToggleBg.Size = UDim2.new(1, 0, 0, 45)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ToggleBg.BorderSizePixel = 0
    ToggleBg.Parent = ContentFrame
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 8)
    TCorner.Parent = ToggleBg
    
    local TText = Instance.new("TextLabel")
    TText.Size = UDim2.new(0.7, 0, 1, 0)
    TText.Position = UDim2.new(0, 15, 0, 0)
    TText.Text = name
    TText.TextColor3 = Color3.fromRGB(230, 230, 230)
    TText.TextSize = 14
    TText.Font = Enum.Font.GothamMedium
    TText.TextXAlignment = Enum.TextXAlignment.Left
    TText.BackgroundTransparency = 1
    TText.Parent = ToggleBg
    
    local TBtn = Instance.new("TextButton")
    TBtn.Size = UDim2.new(0, 45, 0, 22)
    TBtn.Position = UDim2.new(1, -60, 0.5, -11)
    TBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    TBtn.Text = ""
    TBtn.Parent = ToggleBg
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(1, 0)
    BCorner.Parent = TBtn
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 3, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Circle.Parent = TBtn
    
    local CCorner = Instance.new("UICorner")
    CCorner.CornerRadius = UDim.new(1, 0)
    CCorner.Parent = Circle
    
    TBtn.MouseButton1Click:Connect(function()
        Features[featureKey] = not Features[featureKey]
        if Features[featureKey] then
            TBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 120)
            Circle:TweenPosition(UDim2.new(1, -19, 0.5, -8), "Out", "Quad", 0.2, true)
        else
            TBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
            Circle:TweenPosition(UDim2.new(0, 3, 0.5, -8), "Out", "Quad", 0.2, true)
        end
        if callback then callback(Features[featureKey]) end
    end)
end

local function getClosestPlayer()
    local closest = nil
    local shortestDistance = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local mousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if distance < shortestDistance then
                    closest = v.Character.HumanoidRootPart
                    shortestDistance = distance
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if Features.AutoAimShoot then
        local target = getClosestPlayer()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:Button1Down(Vector2.new(0,0), Camera.CFrame)
        end
    end
end)

local function toggleLagBoost(state)
    if state then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
        game:GetService("Lighting").GlobalShadows = false
        settings().Rendering.QualityLevel = 1
    end
end

local function createESP(player)
    if player == LocalPlayer then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_Box"
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Color3 = Color3.fromRGB(255, 0, 100)
    box.Transparency = 0.4
    
    local function apply()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            box.Adornee = player.Character.HumanoidRootPart
            box.Size = Vector3.new(4, 6, 1)
            box.Parent = ScreenGui
        end
    end
    
    player.CharacterAdded:Connect(apply)
    apply()
end

RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        local char = p.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hasESP = char.HumanoidRootPart:FindFirstChild("ESP_Box") or ScreenGui:FindFirstChild("ESP_Box")
            if Features.ESP and not hasESP then
                createESP(p)
            elseif not Features.ESP then
                for _, v in pairs(ScreenGui:GetChildren()) do
                    if v.Name == "ESP_Box" then v:Destroy() end
                end
            end
        end
    end
end)

createToggle("Auto Aim & Shoot (2in1)", "AutoAimShoot")
createToggle("Giảm Lag Tối Đa", "ReduceLag", toggleLagBoost)
createToggle("Boost FPS Mượt Mà", "BoostFPS", toggleLagBoost)
createToggle("Hiện Vị Trí (ESP)", "ESP")

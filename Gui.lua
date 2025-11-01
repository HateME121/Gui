-- gui.lua
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StrikeGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0, 10, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
topBar.Parent = mainFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Parent = topBar

-- Small Open Button
local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 50, 0, 30)
openButton.Position = UDim2.new(0, 10, 0, 10)
openButton.Text = "Open GUI"
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
openButton.Visible = false
openButton.Parent = screenGui

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openButton.Visible = false
end)

-- Tabs
local tabNames = {"Current Event", "Optimization", "Auto Farm", "Egg", "Auto Quest", "Mailbox", "Huge Hunter", "Dupe", "Player", "Misc"}
local tabButtons = {}
local tabContents = {}

local buttonHolder = Instance.new("Frame")
buttonHolder.Name = "ButtonHolder"
buttonHolder.Size = UDim2.new(1, 0, 0, 30)
buttonHolder.Position = UDim2.new(0, 0, 0, 30)
buttonHolder.BackgroundTransparency = 1
buttonHolder.Parent = mainFrame

local contentHolder = Instance.new("Frame")
contentHolder.Name = "ContentHolder"
contentHolder.Size = UDim2.new(1, 0, 1, -60)
contentHolder.Position = UDim2.new(0, 0, 0, 60)
contentHolder.BackgroundTransparency = 1
contentHolder.Parent = mainFrame

local function createTab(name, index)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 80, 1, 0)
    button.Position = UDim2.new(0, (index-1)*80, 0, 0)
    button.Text = name
    button.TextColor3 = Color3.new(1,1,1)
    button.BackgroundColor3 = Color3.fromRGB(50,50,50)
    button.Parent = buttonHolder

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundColor3 = Color3.fromRGB(40,40,40)
    content.Visible = false
    content.Parent = contentHolder

    button.MouseButton1Click:Connect(function()
        for _, c in pairs(tabContents) do
            c.Visible = false
        end
        content.Visible = true
    end)

    table.insert(tabButtons, button)
    table.insert(tabContents, content)
end

for i, name in ipairs(tabNames) do
    createTab(name, i)
end

-- Activate first tab
tabContents[1].Visible = true

-- Dragging after 5 seconds
local dragging = false
local dragStart, startPos

delay(5, function()
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    topBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end)

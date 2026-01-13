--[[
    xqtz Script Loader
    Arms of Conquest Admin Menu
]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup existing UI
if playerGui:FindFirstChild("xqtzLoader") then
    playerGui:FindFirstChild("xqtzLoader"):Destroy()
end

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "xqtzLoader"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main background frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.Position = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 12, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Gradient overlay
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 12, 18)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 12, 18))
})
gradient.Rotation = 45
gradient.Parent = mainFrame

-- Container for centered content
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0, 500, 0, 400)
container.Position = UDim2.new(0.5, -250, 0.5, -200)
container.BackgroundTransparency = 1
container.Parent = mainFrame

-- xqtz Logo
local logo = Instance.new("TextLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(1, 0, 0, 120)
logo.Position = UDim2.new(0, 0, 0, 20)
logo.BackgroundTransparency = 1
logo.Text = "xqtz"
logo.Font = Enum.Font.GothamBlack
logo.TextSize = 90
logo.TextColor3 = Color3.fromRGB(0, 255, 255)
logo.TextTransparency = 1
logo.Parent = container

-- Logo glow effect (shadow)
local logoGlow = Instance.new("TextLabel")
logoGlow.Name = "LogoGlow"
logoGlow.Size = UDim2.new(1, 0, 0, 120)
logoGlow.Position = UDim2.new(0, 2, 0, 22)
logoGlow.BackgroundTransparency = 1
logoGlow.Text = "xqtz"
logoGlow.Font = Enum.Font.GothamBlack
logoGlow.TextSize = 90
logoGlow.TextColor3 = Color3.fromRGB(0, 200, 200)
logoGlow.TextTransparency = 1
logoGlow.ZIndex = 0
logoGlow.Parent = container

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Size = UDim2.new(1, 0, 0, 30)
subtitle.Position = UDim2.new(0, 0, 0, 140)
subtitle.BackgroundTransparency = 1
subtitle.Text = "SCRIPT LOADER"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 16
subtitle.TextColor3 = Color3.fromRGB(100, 150, 170)
subtitle.TextTransparency = 1
logo.Parent = container
subtitle.Parent = container

-- Decorative line
local line = Instance.new("Frame")
line.Name = "Line"
line.Size = UDim2.new(0, 0, 0, 2)
line.Position = UDim2.new(0.5, 0, 0, 180)
line.AnchorPoint = Vector2.new(0.5, 0)
line.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
line.BorderSizePixel = 0
line.BackgroundTransparency = 1
line.Parent = container

local lineGradient = Instance.new("UIGradient")
lineGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 12, 18)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 12, 18))
})
lineGradient.Parent = line

-- Script box
local scriptBox = Instance.new("Frame")
scriptBox.Name = "ScriptBox"
scriptBox.Size = UDim2.new(1, -40, 0, 80)
scriptBox.Position = UDim2.new(0, 20, 0, 200)
scriptBox.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
scriptBox.BorderSizePixel = 0
scriptBox.BackgroundTransparency = 1
scriptBox.Parent = container

local scriptBoxCorner = Instance.new("UICorner")
scriptBoxCorner.CornerRadius = UDim.new(0, 8)
scriptBoxCorner.Parent = scriptBox

local scriptBoxStroke = Instance.new("UIStroke")
scriptBoxStroke.Color = Color3.fromRGB(0, 255, 255)
scriptBoxStroke.Thickness = 1
scriptBoxStroke.Transparency = 1
scriptBoxStroke.Parent = scriptBox

-- Terminal dots
local dotsContainer = Instance.new("Frame")
dotsContainer.Size = UDim2.new(1, -16, 0, 20)
dotsContainer.Position = UDim2.new(0, 8, 0, 8)
dotsContainer.BackgroundTransparency = 1
dotsContainer.Parent = scriptBox

local colors = {Color3.fromRGB(255, 95, 87), Color3.fromRGB(255, 189, 46), Color3.fromRGB(39, 201, 63)}
for i = 1, 3 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(0, (i-1) * 16, 0, 5)
    dot.BackgroundColor3 = colors[i]
    dot.BorderSizePixel = 0
    dot.Parent = dotsContainer
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
end

-- Script text
local scriptText = Instance.new("TextLabel")
scriptText.Name = "ScriptText"
scriptText.Size = UDim2.new(1, -20, 0, 40)
scriptText.Position = UDim2.new(0, 10, 0, 32)
scriptText.BackgroundTransparency = 1
scriptText.Text = ">> "
scriptText.Font = Enum.Font.Code
scriptText.TextSize = 12
scriptText.TextColor3 = Color3.fromRGB(0, 255, 255)
scriptText.TextXAlignment = Enum.TextXAlignment.Left
scriptText.TextWrapped = true
scriptText.Parent = scriptBox

-- Loading bar background
local loadingBarBg = Instance.new("Frame")
loadingBarBg.Name = "LoadingBarBg"
loadingBarBg.Size = UDim2.new(1, -40, 0, 8)
loadingBarBg.Position = UDim2.new(0, 20, 0, 300)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 40, 50)
loadingBarBg.BorderSizePixel = 0
loadingBarBg.BackgroundTransparency = 1
loadingBarBg.Parent = container

local loadingBarBgCorner = Instance.new("UICorner")
loadingBarBgCorner.CornerRadius = UDim.new(1, 0)
loadingBarBgCorner.Parent = loadingBarBg

-- Loading bar fill
local loadingBar = Instance.new("Frame")
loadingBar.Name = "LoadingBar"
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.Position = UDim2.new(0, 0, 0, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
loadingBar.BorderSizePixel = 0
loadingBar.Parent = loadingBarBg

local loadingBarCorner = Instance.new("UICorner")
loadingBarCorner.CornerRadius = UDim.new(1, 0)
loadingBarCorner.Parent = loadingBar

local loadingBarGradient = Instance.new("UIGradient")
loadingBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 255, 255))
})
loadingBarGradient.Parent = loadingBar

-- Status text
local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(1, -40, 0, 25)
statusText.Position = UDim2.new(0, 20, 0, 315)
statusText.BackgroundTransparency = 1
statusText.Text = "Initializing..."
statusText.Font = Enum.Font.Gotham
statusText.TextSize = 14
statusText.TextColor3 = Color3.fromRGB(100, 150, 170)
statusText.TextTransparency = 1
statusText.Parent = container

-- Percentage text
local percentText = Instance.new("TextLabel")
percentText.Name = "PercentText"
percentText.Size = UDim2.new(0, 50, 0, 25)
percentText.Position = UDim2.new(1, -70, 0, 315)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.Font = Enum.Font.GothamBold
percentText.TextSize = 14
percentText.TextColor3 = Color3.fromRGB(0, 255, 255)
percentText.TextTransparency = 1
percentText.Parent = container

-- Footer
local footer = Instance.new("TextLabel")
footer.Name = "Footer"
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 0, 360)
footer.BackgroundTransparency = 1
footer.Text = "Made with 💜 by xqtz"
footer.Font = Enum.Font.Gotham
footer.TextSize = 12
footer.TextColor3 = Color3.fromRGB(150, 100, 200)
footer.TextTransparency = 1
footer.Parent = container

-- Animation helper
local function tween(obj, props, duration, style, direction)
    style = style or Enum.EasingStyle.Quart
    direction = direction or Enum.EasingDirection.Out
    local tweenInfo = TweenInfo.new(duration, style, direction)
    local t = TweenService:Create(obj, tweenInfo, props)
    t:Play()
    return t
end

-- Glitch effect for logo
local glitchChars = {"!", "@", "#", "$", "%", "^", "&", "*", "?", "~"}
local originalText = "xqtz"

local function glitchEffect()
    spawn(function()
        while logo and logo.Parent do
            wait(math.random(2, 5))
            local glitched = ""
            for i = 1, #originalText do
                if math.random() > 0.7 then
                    glitched = glitched .. glitchChars[math.random(1, #glitchChars)]
                else
                    glitched = glitched .. originalText:sub(i, i)
                end
            end
            logo.Text = glitched
            logoGlow.Text = glitched
            
            -- RGB split effect
            logo.Position = UDim2.new(0, math.random(-3, 3), 0, 20 + math.random(-2, 2))
            wait(0.05)
            logo.Text = originalText
            logoGlow.Text = originalText
            logo.Position = UDim2.new(0, 0, 0, 20)
        end
    end)
end

-- Typing effect
local function typeText(label, text, speed)
    speed = speed or 0.02
    label.Text = ">> "
    for i = 1, #text do
        label.Text = ">> " .. text:sub(1, i)
        wait(speed)
    end
end

-- Status messages
local statuses = {
    {0, "Initializing..."},
    {15, "Connecting to server..."},
    {30, "Fetching script..."},
    {50, "Decrypting payload..."},
    {70, "Injecting modules..."},
    {85, "Bypassing security..."},
    {95, "Finalizing..."},
    {100, "Loading complete!"}
}

-- Main animation sequence
spawn(function()
    wait(0.5)
    
    -- Fade in logo with glow
    tween(logoGlow, {TextTransparency = 0.5}, 0.8)
    tween(logo, {TextTransparency = 0}, 0.8)
    glitchEffect()
    
    wait(0.6)
    
    -- Fade in subtitle
    tween(subtitle, {TextTransparency = 0}, 0.5)
    
    wait(0.4)
    
    -- Animate line
    tween(line, {BackgroundTransparency = 0, Size = UDim2.new(0.6, 0, 0, 2)}, 0.6)
    
    wait(0.4)
    
    -- Fade in script box
    tween(scriptBox, {BackgroundTransparency = 0}, 0.4)
    tween(scriptBoxStroke, {Transparency = 0.5}, 0.4)
    
    wait(0.3)
    
    -- Type the script
    local scriptUrl = "loadstring(game:HttpGet([[https://raw.githubusercontent.com/xqtz/xqtz-Core/...]]))()"
    typeText(scriptText, scriptUrl, 0.015)
    
    wait(0.3)
    
    -- Fade in loading elements
    tween(loadingBarBg, {BackgroundTransparency = 0}, 0.3)
    tween(statusText, {TextTransparency = 0}, 0.3)
    tween(percentText, {TextTransparency = 0}, 0.3)
    tween(footer, {TextTransparency = 0.3}, 0.3)
    
    wait(0.2)
    
    -- Loading animation
    local duration = 3
    local startTime = tick()
    local statusIndex = 1
    
    while tick() - startTime < duration do
        local progress = (tick() - startTime) / duration
        local percent = math.floor(progress * 100)
        
        percentText.Text = percent .. "%"
        tween(loadingBar, {Size = UDim2.new(progress, 0, 1, 0)}, 0.1, Enum.EasingStyle.Linear)
        
        -- Update status
        for i, status in ipairs(statuses) do
            if percent >= status[1] and i > statusIndex then
                statusIndex = i
                statusText.Text = status[2]
            end
        end
        
        wait(0.03)
    end
    
    -- Complete
    percentText.Text = "100%"
    statusText.Text = "Loading complete!"
    statusText.TextColor3 = Color3.fromRGB(0, 255, 150)
    tween(loadingBar, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
    
    wait(0.5)
    
    -- Success flash
    tween(loadingBar, {BackgroundColor3 = Color3.fromRGB(0, 255, 150)}, 0.2)
    
    wait(1)
    
    -- Fade out
    tween(mainFrame, {BackgroundTransparency = 1}, 0.5)
    for _, child in pairs(container:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("Frame") then
            pcall(function()
                tween(child, {BackgroundTransparency = 1, TextTransparency = 1}, 0.5)
            end)
        end
    end
    
    wait(0.6)
    
    -- Cleanup and execute
    screenGui:Destroy()
    
    -- Execute the actual script
    loadstring(game:HttpGet([[https://raw.githubusercontent.com/xqtz/xqtz-Core/refs/heads/main/Arms%20of%20Conquest%20admin%20menu]]))()
end)

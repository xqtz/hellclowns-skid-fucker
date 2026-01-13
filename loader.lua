local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hide Roblox UI
local function setCore(name, value)
    pcall(function()
        StarterGui:SetCoreGuiEnabled(name, value)
    end)
end

setCore(Enum.CoreGuiType.All, false)

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "xqtz_BootLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame (Full Screen)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "BootScreen"
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.Position = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Scanline overlay effect
local scanlines = Instance.new("Frame")
scanlines.Name = "Scanlines"
scanlines.Size = UDim2.new(1, 0, 1, 0)
scanlines.BackgroundTransparency = 0.95
scanlines.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
scanlines.BorderSizePixel = 0
scanlines.Parent = mainFrame

-- ASCII Logo
local asciiArt = [[
                                                           
    ██╗  ██╗ ██████╗ ████████╗███████╗
    ╚██╗██╔╝██╔═══██╗╚══██╔══╝╚══███╔╝
     ╚███╔╝ ██║   ██║   ██║     ███╔╝ 
     ██╔██╗ ██║▄▄ ██║   ██║    ███╔╝  
    ██╔╝ ██╗╚██████╔╝   ██║   ███████╗
    ╚═╝  ╚═╝ ╚══▀▀═╝    ╚═╝   ╚══════╝
              [ CORE SYSTEMS ]
]]

local logoLabel = Instance.new("TextLabel")
logoLabel.Name = "Logo"
logoLabel.Size = UDim2.new(1, 0, 0, 150)
logoLabel.Position = UDim2.new(0, 0, 0.08, 0)
logoLabel.BackgroundTransparency = 1
logoLabel.Font = Enum.Font.Code
logoLabel.TextColor3 = Color3.fromRGB(0, 255, 65)
logoLabel.TextSize = 14
logoLabel.Text = asciiArt
logoLabel.TextTransparency = 1
logoLabel.Parent = mainFrame

-- Terminal Output Container
local terminalFrame = Instance.new("ScrollingFrame")
terminalFrame.Name = "Terminal"
terminalFrame.Size = UDim2.new(0.9, 0, 0.45, 0)
terminalFrame.Position = UDim2.new(0.05, 0, 0.28, 0)
terminalFrame.BackgroundTransparency = 1
terminalFrame.BorderSizePixel = 0
terminalFrame.ScrollBarThickness = 0
terminalFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
terminalFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
terminalFrame.Parent = mainFrame

local terminalLayout = Instance.new("UIListLayout")
terminalLayout.SortOrder = Enum.SortOrder.LayoutOrder
terminalLayout.Padding = UDim.new(0, 2)
terminalLayout.Parent = terminalFrame

-- Progress Bar Container
local progressContainer = Instance.new("Frame")
progressContainer.Name = "ProgressContainer"
progressContainer.Size = UDim2.new(0.8, 0, 0, 30)
progressContainer.Position = UDim2.new(0.1, 0, 0.78, 0)
progressContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
progressContainer.BorderColor3 = Color3.fromRGB(0, 255, 65)
progressContainer.BorderSizePixel = 2
progressContainer.Parent = mainFrame

local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 65)
progressBar.BorderSizePixel = 0
progressBar.Parent = progressContainer

local progressGlow = Instance.new("Frame")
progressGlow.Name = "Glow"
progressGlow.Size = UDim2.new(1, 0, 1, 0)
progressGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
progressGlow.BackgroundTransparency = 0.5
progressGlow.BorderSizePixel = 0
progressGlow.Parent = progressBar

-- Progress Text
local progressText = Instance.new("TextLabel")
progressText.Name = "ProgressText"
progressText.Size = UDim2.new(1, 0, 0, 25)
progressText.Position = UDim2.new(0, 0, 0.83, 0)
progressText.BackgroundTransparency = 1
progressText.Font = Enum.Font.Code
progressText.TextColor3 = Color3.fromRGB(0, 255, 65)
progressText.TextSize = 16
progressText.Text = "INITIALIZING SYSTEM... 0%"
progressText.Parent = mainFrame

-- Status Text
local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(1, 0, 0, 20)
statusText.Position = UDim2.new(0, 0, 0.88, 0)
statusText.BackgroundTransparency = 1
statusText.Font = Enum.Font.Code
statusText.TextColor3 = Color3.fromRGB(180, 0, 0)
statusText.TextSize = 14
statusText.Text = ""
statusText.Parent = mainFrame

-- Warning Text (Bottom)
local warningText = Instance.new("TextLabel")
warningText.Name = "Warning"
warningText.Size = UDim2.new(1, 0, 0, 20)
warningText.Position = UDim2.new(0, 0, 0.95, 0)
warningText.BackgroundTransparency = 1
warningText.Font = Enum.Font.Code
warningText.TextColor3 = Color3.fromRGB(100, 100, 100)
warningText.TextSize = 12
warningText.Text = "[ UNAUTHORIZED ACCESS DETECTED - BYPASSING SECURITY ]"
warningText.Parent = mainFrame

-- Boot Messages
local bootMessages = {
    {text = "[KERNEL] Initializing xqtz Core Systems...", delay = 0.1, color = Color3.fromRGB(0, 255, 65)},
    {text = "[KERNEL] Loading kernel modules...", delay = 0.08, color = Color3.fromRGB(0, 255, 65)},
    {text = "[OK] CPU: Identified x86_64 architecture", delay = 0.05, color = Color3.fromRGB(0, 200, 255)},
    {text = "[OK] Memory: 16384 MB detected", delay = 0.05, color = Color3.fromRGB(0, 200, 255)},
    {text = "[WARN] Security protocols: DISABLED", delay = 0.1, color = Color3.fromRGB(255, 200, 0)},
    {text = "[OK] Network interface: eth0 UP", delay = 0.05, color = Color3.fromRGB(0, 200, 255)},
    {text = "[KERNEL] Mounting filesystems...", delay = 0.08, color = Color3.fromRGB(0, 255, 65)},
    {text = "[OK] /dev/sda1 mounted on /", delay = 0.05, color = Color3.fromRGB(0, 200, 255)},
    {text = "[OK] /dev/sda2 mounted on /home", delay = 0.05, color = Color3.fromRGB(0, 200, 255)},
    {text = "[CRIT] FIREWALL BREACH DETECTED", delay = 0.15, color = Color3.fromRGB(255, 0, 0)},
    {text = "[KERNEL] Bypassing security layer 1...", delay = 0.1, color = Color3.fromRGB(0, 255, 65)},
    {text = "[KERNEL] Bypassing security layer 2...", delay = 0.1, color = Color3.fromRGB(0, 255, 65)},
    {text = "[KERNEL] Bypassing security layer 3...", delay = 0.1, color = Color3.fromRGB(0, 255, 65)},
    {text = "[OK] Security bypass complete", delay = 0.08, color = Color3.fromRGB(0, 200, 255)},
    {text = "[KERNEL] Loading xqtz injection framework...", delay = 0.1, color = Color3.fromRGB(0, 255, 65)},
    {text = "[OK] Hook library initialized", delay = 0.05, color = Color3.fromRGB(0, 200, 255)},
    {text = "[OK] Script executor ready", delay = 0.05, color = Color3.fromRGB(0, 200, 255)},
    {text = "[KERNEL] Establishing remote connection...", delay = 0.12, color = Color3.fromRGB(0, 255, 65)},
    {text = "[OK] Connected to xqtz-Core repository", delay = 0.08, color = Color3.fromRGB(0, 200, 255)},
    {text = "[KERNEL] Downloading payload...", delay = 0.15, color = Color3.fromRGB(0, 255, 65)},
    {text = "[OK] Payload verified: SHA256 match", delay = 0.08, color = Color3.fromRGB(0, 200, 255)},
    {text = "[KERNEL] Preparing execution environment...", delay = 0.1, color = Color3.fromRGB(0, 255, 65)},
    {text = "[OK] Environment ready", delay = 0.05, color = Color3.fromRGB(0, 200, 255)},
    {text = "[KERNEL] Starting xqtz Admin Panel...", delay = 0.12, color = Color3.fromRGB(0, 255, 65)},
    {text = "[OK] ALL SYSTEMS OPERATIONAL", delay = 0.1, color = Color3.fromRGB(0, 255, 0)},
}

-- Typewriter effect function
local function typewrite(label, text, speed)
    label.Text = ""
    for i = 1, #text do
        label.Text = string.sub(text, 1, i)
        task.wait(speed or 0.02)
    end
end

-- Add terminal line function
local lineCount = 0
local function addTerminalLine(text, color)
    lineCount = lineCount + 1
    local line = Instance.new("TextLabel")
    line.Name = "Line" .. lineCount
    line.Size = UDim2.new(1, 0, 0, 16)
    line.BackgroundTransparency = 1
    line.Font = Enum.Font.Code
    line.TextColor3 = color or Color3.fromRGB(0, 255, 65)
    line.TextSize = 14
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.Text = ""
    line.LayoutOrder = lineCount
    line.Parent = terminalFrame
    
    -- Typewriter effect
    for i = 1, #text do
        line.Text = string.sub(text, 1, i)
        if i % 3 == 0 then
            task.wait(0.01)
        end
    end
    
    -- Auto scroll
    terminalFrame.CanvasPosition = Vector2.new(0, terminalFrame.AbsoluteCanvasSize.Y)
    
    return line
end

-- Flicker effect
local function flicker(element, times, interval)
    for i = 1, times do
        element.Visible = false
        task.wait(interval or 0.05)
        element.Visible = true
        task.wait(interval or 0.05)
    end
end

-- Glitch effect on text
local function glitchText(label, originalText, duration)
    local chars = "!@#$%^&*()_+-=[]{}|;':\",./<>?0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    local endTime = tick() + duration
    while tick() < endTime do
        local glitched = ""
        for i = 1, #originalText do
            if math.random() > 0.7 then
                local randIndex = math.random(1, #chars)
                glitched = glitched .. string.sub(chars, randIndex, randIndex)
            else
                glitched = glitched .. string.sub(originalText, i, i)
            end
        end
        label.Text = glitched
        task.wait(0.03)
    end
    label.Text = originalText
end

-- Progress stages
local progressStages = {
    {percent = 0, status = "INITIALIZING SYSTEM..."},
    {percent = 25, status = "LOADING KERNEL MODULES..."},
    {percent = 50, status = "BYPASSING SECURITY..."},
    {percent = 75, status = "ESTABLISHING CONNECTION..."},
    {percent = 100, status = "INJECTION COMPLETE"},
}

-- Main boot sequence
spawn(function()
    task.wait(0.5)
    
    -- Fade in logo with flicker
    local logoTween = TweenService:Create(logoLabel, TweenInfo.new(0.5), {TextTransparency = 0})
    logoTween:Play()
    logoTween.Completed:Wait()
    flicker(logoLabel, 3, 0.08)
    
    task.wait(0.3)
    
    -- Glitch the logo briefly
    spawn(function()
        glitchText(logoLabel, asciiArt, 0.5)
    end)
    
    task.wait(0.8)
    
    local currentStage = 1
    local messageIndex = 1
    local messagesPerStage = math.ceil(#bootMessages / (#progressStages - 1))
    
    -- Process boot messages with staged progress
    for i, msg in ipairs(bootMessages) do
        -- Check if we should advance progress stage
        local stageThreshold = (currentStage) * messagesPerStage
        if i >= stageThreshold and currentStage < #progressStages then
            currentStage = currentStage + 1
            local stage = progressStages[currentStage]
            
            -- Animate progress bar
            local progressTween = TweenService:Create(
                progressBar, 
                TweenInfo.new(0.5, Enum.EasingStyle.Quad), 
                {Size = UDim2.new(stage.percent / 100, 0, 1, 0)}
            )
            progressTween:Play()
            
            progressText.Text = stage.status .. " " .. stage.percent .. "%"
            
            -- Flicker effect on milestone
            if stage.percent == 50 or stage.percent == 100 then
                spawn(function()
                    flicker(mainFrame, 2, 0.04)
                end)
            end
        end
        
        -- Add the terminal message
        addTerminalLine(msg.text, msg.color)
        task.wait(msg.delay)
        
        -- Random glitch chance
        if math.random() > 0.9 then
            spawn(function()
                local randLine = terminalFrame:FindFirstChild("Line" .. math.random(1, lineCount))
                if randLine then
                    local original = randLine.Text
                    glitchText(randLine, original, 0.2)
                end
            end)
        end
    end
    
    -- Final progress to 100%
    local finalTween = TweenService:Create(
        progressBar, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad), 
        {Size = UDim2.new(1, 0, 1, 0)}
    )
    finalTween:Play()
    progressText.Text = "INJECTION COMPLETE 100%"
    progressText.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    task.wait(0.5)
    
    -- Success message with flicker
    statusText.Text = "[ xqtz CORE LOADED SUCCESSFULLY ]"
    statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
    flicker(statusText, 5, 0.1)
    
    task.wait(1)
    
    -- Final glitch before fade out
    spawn(function()
        glitchText(logoLabel, asciiArt, 0.3)
    end)
    
    task.wait(0.5)
    
    -- Fade out
    local fadeOut = TweenService:Create(mainFrame, TweenInfo.new(1, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
    
    for _, child in pairs(mainFrame:GetDescendants()) do
        if child:IsA("TextLabel") then
            spawn(function()
                local tween = TweenService:Create(child, TweenInfo.new(1), {TextTransparency = 1})
                tween:Play()
            end)
        elseif child:IsA("Frame") then
            spawn(function()
                local tween = TweenService:Create(child, TweenInfo.new(1), {BackgroundTransparency = 1})
                tween:Play()
            end)
        end
    end
    
    fadeOut:Play()
    fadeOut.Completed:Wait()
    
    -- Cleanup
    screenGui:Destroy()
    
    -- Restore Roblox UI
    setCore(Enum.CoreGuiType.All, true)
    
    -- Execute the payload
    task.wait(0.5)
    loadstring(game:HttpGet([[https://raw.githubusercontent.com/xqtz/xqtz-Core/refs/heads/main/Arms%20of%20Conquest%20admin%20menu]]))()
end)

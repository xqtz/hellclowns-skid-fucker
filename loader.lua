--[[
    ██╗  ██╗ ██████╗ ████████╗███████╗
    ╚██╗██╔╝██╔═══██╗╚══██╔══╝╚══███╔╝
     ╚███╔╝ ██║   ██║   ██║     ███╔╝ 
     ██╔██╗ ██║▄▄ ██║   ██║    ███╔╝  
    ██╔╝ ██╗╚██████╔╝   ██║   ███████╗
    ╚═╝  ╚═╝ ╚══▀▀═╝    ╚═╝   ╚══════╝
    
    Arms of Conquest Admin Menu Loader
    github.com/xqtz
]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup existing UI
if playerGui:FindFirstChild("xqtzLoader") then
    playerGui:FindFirstChild("xqtzLoader"):Destroy()
end

-- Colors
local colors = {
    bg = Color3.fromRGB(13, 17, 23),
    terminal = Color3.fromRGB(22, 27, 34),
    green = Color3.fromRGB(88, 166, 92),
    brightGreen = Color3.fromRGB(126, 231, 135),
    cyan = Color3.fromRGB(121, 192, 255),
    yellow = Color3.fromRGB(210, 168, 75),
    red = Color3.fromRGB(248, 81, 73),
    purple = Color3.fromRGB(188, 140, 255),
    gray = Color3.fromRGB(139, 148, 158),
    white = Color3.fromRGB(201, 209, 217),
}

-- ASCII Art Logo
local asciiLogo = [[
 ██╗  ██╗ ██████╗ ████████╗███████╗
 ╚██╗██╔╝██╔═══██╗╚══██╔══╝╚══███╔╝
  ╚███╔╝ ██║   ██║   ██║     ███╔╝ 
  ██╔██╗ ██║▄▄ ██║   ██║    ███╔╝  
 ██╔╝ ██╗╚██████╔╝   ██║   ███████╗
 ╚═╝  ╚═╝ ╚══▀▀═╝    ╚═╝   ╚══════╝]]

-- Create main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "xqtzLoader"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main background
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = colors.bg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- CRT scanlines overlay
local scanlines = Instance.new("Frame")
scanlines.Name = "Scanlines"
scanlines.Size = UDim2.new(1, 0, 1, 0)
scanlines.BackgroundTransparency = 0.95
scanlines.BackgroundColor3 = Color3.new(0, 0, 0)
scanlines.BorderSizePixel = 0
scanlines.ZIndex = 10
scanlines.Parent = mainFrame

-- Terminal window
local terminal = Instance.new("Frame")
terminal.Name = "Terminal"
terminal.Size = UDim2.new(0, 700, 0, 500)
terminal.Position = UDim2.new(0.5, -350, 0.5, -250)
terminal.BackgroundColor3 = colors.terminal
terminal.BorderSizePixel = 0
terminal.Parent = mainFrame

local terminalCorner = Instance.new("UICorner")
terminalCorner.CornerRadius = UDim.new(0, 10)
terminalCorner.Parent = terminal

local terminalStroke = Instance.new("UIStroke")
terminalStroke.Color = colors.gray
terminalStroke.Thickness = 1
terminalStroke.Transparency = 0.7
terminalStroke.Parent = terminal

-- Terminal header bar
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
header.BorderSizePixel = 0
header.Parent = terminal

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

-- Fix corner - only round top
local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 15)
headerFix.Position = UDim2.new(0, 0, 1, -15)
headerFix.BackgroundColor3 = Color3.fromRGB(30, 35, 42)
headerFix.BorderSizePixel = 0
headerFix.Parent = header

-- Window buttons
local buttonColors = {colors.red, colors.yellow, colors.green}
for i = 1, 3 do
    local btn = Instance.new("Frame")
    btn.Size = UDim2.new(0, 12, 0, 12)
    btn.Position = UDim2.new(0, 12 + (i-1) * 20, 0.5, -6)
    btn.BackgroundColor3 = buttonColors[i]
    btn.BorderSizePixel = 0
    btn.Parent = header
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = btn
end

-- Terminal title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "xqtz@arch ~ bash"
title.Font = Enum.Font.Code
title.TextSize = 13
title.TextColor3 = colors.gray
title.Parent = header

-- Terminal content area
local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -50)
content.Position = UDim2.new(0, 10, 0, 40)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = colors.green
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = terminal

local contentLayout = Instance.new("UIListLayout")
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 2)
contentLayout.Parent = content

-- Helper to add terminal line
local lineOrder = 0
local function addLine(text, color, prefix, instant)
    color = color or colors.white
    prefix = prefix or ""
    
    local line = Instance.new("TextLabel")
    line.Name = "Line" .. lineOrder
    line.Size = UDim2.new(1, 0, 0, 0)
    line.AutomaticSize = Enum.AutomaticSize.Y
    line.BackgroundTransparency = 1
    line.Text = prefix .. text
    line.Font = Enum.Font.Code
    line.TextSize = 14
    line.TextColor3 = color
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.TextWrapped = true
    line.RichText = true
    line.LayoutOrder = lineOrder
    line.TextTransparency = instant and 0 or 1
    line.Parent = content
    
    lineOrder = lineOrder + 1
    
    if not instant then
        -- Typewriter effect
        local fullText = prefix .. text
        line.Text = ""
        line.TextTransparency = 0
        
        spawn(function()
            for i = 1, #fullText do
                line.Text = fullText:sub(1, i)
                wait(0.008)
            end
        end)
    end
    
    -- Auto scroll
    content.CanvasPosition = Vector2.new(0, content.AbsoluteCanvasSize.Y)
    
    return line
end

-- Add ASCII logo lines
local function addAsciiLogo()
    for logoLine in asciiLogo:gmatch("[^\n]+") do
        local line = Instance.new("TextLabel")
        line.Size = UDim2.new(1, 0, 0, 16)
        line.BackgroundTransparency = 1
        line.Text = logoLine
        line.Font = Enum.Font.Code
        line.TextSize = 14
        line.TextColor3 = colors.brightGreen
        line.TextXAlignment = Enum.TextXAlignment.Left
        line.LayoutOrder = lineOrder
        line.TextTransparency = 1
        line.Parent = content
        lineOrder = lineOrder + 1
        
        TweenService:Create(line, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        wait(0.05)
    end
end

-- Progress bar in terminal
local function createProgressBar(label)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 20)
    container.BackgroundTransparency = 1
    container.LayoutOrder = lineOrder
    container.Parent = content
    lineOrder = lineOrder + 1
    
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0, 200, 1, 0)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.Font = Enum.Font.Code
    labelText.TextSize = 14
    labelText.TextColor3 = colors.cyan
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = container
    
    local barBg = Instance.new("TextLabel")
    barBg.Size = UDim2.new(0, 300, 0, 14)
    barBg.Position = UDim2.new(0, 210, 0.5, -7)
    barBg.BackgroundTransparency = 1
    barBg.Text = "[                              ]"
    barBg.Font = Enum.Font.Code
    barBg.TextSize = 14
    barBg.TextColor3 = colors.gray
    barBg.TextXAlignment = Enum.TextXAlignment.Left
    barBg.Parent = container
    
    local percent = Instance.new("TextLabel")
    percent.Size = UDim2.new(0, 50, 1, 0)
    percent.Position = UDim2.new(0, 520, 0, 0)
    percent.BackgroundTransparency = 1
    percent.Text = "0%"
    percent.Font = Enum.Font.Code
    percent.TextSize = 14
    percent.TextColor3 = colors.yellow
    percent.TextXAlignment = Enum.TextXAlignment.Left
    percent.Parent = container
    
    return {
        update = function(progress)
            local filled = math.floor(progress * 30)
            local bar = "[" .. string.rep("█", filled) .. string.rep("░", 30 - filled) .. "]"
            barBg.Text = bar
            barBg.TextColor3 = progress >= 1 and colors.brightGreen or colors.green
            percent.Text = math.floor(progress * 100) .. "%"
            percent.TextColor3 = progress >= 1 and colors.brightGreen or colors.yellow
        end
    }
end

-- Boot sequence
local bootMessages = {
    {text = "Linux 6.5.0-arch1-1 (tty1)", color = colors.white, delay = 0.1},
    {text = "", delay = 0.05},
    {text = "xqtz login: root", color = colors.white, delay = 0.2},
    {text = "Password: ************", color = colors.white, delay = 0.3},
    {text = "", delay = 0.1},
    {text = "[  OK  ] Started Session 1 of user root.", color = colors.green, delay = 0.15},
    {text = "", delay = 0.1},
}

local systemMessages = {
    {text = "$ neofetch", color = colors.cyan, delay = 0.3},
}

local infoMessages = {
    {text = "       OS: Arch Linux x86_64", color = colors.white},
    {text = "   Kernel: 6.5.0-arch1-1", color = colors.white},
    {text = "  Uptime: 0 mins", color = colors.white},
    {text = " Packages: 1337 (pacman)", color = colors.white},
    {text = "    Shell: bash 5.2.15", color = colors.white},
    {text = "  Terminal: /dev/tty1", color = colors.white},
    {text = "      CPU: xqtz Core @ 4.20GHz", color = colors.white},
    {text = "   Memory: 420MB / 16384MB", color = colors.white},
}

local loadSequence = {
    {text = "$ sudo ./xqtz-loader.sh", color = colors.cyan},
    {text = "[sudo] password for root: ************", color = colors.white, delay = 0.4},
    {text = "", delay = 0.1},
    {text = "[*] Initializing xqtz Core...", color = colors.purple},
    {text = "[*] Checking dependencies...", color = colors.gray},
    {text = "    ├── curl: OK", color = colors.green},
    {text = "    ├── wget: OK", color = colors.green},
    {text = "    ├── lua5.4: OK", color = colors.green},
    {text = "    └── injector: OK", color = colors.green},
    {text = "", delay = 0.05},
    {text = "[*] Connecting to github.com/xqtz...", color = colors.gray},
    {text = "[+] Connection established (ping: 13ms)", color = colors.green},
    {text = "", delay = 0.05},
    {text = "[*] Fetching payload from remote...", color = colors.gray},
    {text = "    GET /xqtz/xqtz-Core/main/Arms%20of%20Conquest", color = colors.gray},
    {text = "[+] HTTP 200 OK (Size: 42.0 KB)", color = colors.green},
    {text = "", delay = 0.05},
}

local injectionSequence = {
    {text = "[*] Decrypting payload...", color = colors.yellow, progress = true, label = "Decrypting"},
    {text = "[+] Payload decrypted successfully", color = colors.green},
    {text = "", delay = 0.05},
    {text = "[*] Bypassing anti-cheat...", color = colors.red, progress = true, label = "Bypassing"},
    {text = "[+] Anti-cheat bypassed", color = colors.green},
    {text = "", delay = 0.05},
    {text = "[*] Injecting modules...", color = colors.purple, progress = true, label = "Injecting"},
    {text = "[+] Modules injected (23 functions loaded)", color = colors.green},
    {text = "", delay = 0.05},
}

local finalSequence = {
    {text = "═══════════════════════════════════════════════════════", color = colors.brightGreen},
    {text = "[SUCCESS] Arms of Conquest Admin Menu loaded!", color = colors.brightGreen},
    {text = "═══════════════════════════════════════════════════════", color = colors.brightGreen},
    {text = "", delay = 0.1},
    {text = "Press any key to continue...", color = colors.gray},
}

-- Main execution
spawn(function()
    wait(0.5)
    
    -- Boot messages
    for _, msg in ipairs(bootMessages) do
        if msg.text ~= "" then
            addLine(msg.text, msg.color, "", true)
        else
            addLine(" ", colors.white, "", true)
        end
        wait(msg.delay or 0.1)
    end
    
    -- System commands
    for _, msg in ipairs(systemMessages) do
        addLine(msg.text, msg.color)
        wait(msg.delay or 0.3)
    end
    
    wait(0.5)
    
    -- ASCII Logo
    addAsciiLogo()
    wait(0.3)
    
    -- System info
    for _, msg in ipairs(infoMessages) do
        addLine(msg.text, msg.color, "", true)
        wait(0.05)
    end
    
    addLine("", colors.white, "", true)
    wait(0.5)
    
    -- Load sequence
    for _, msg in ipairs(loadSequence) do
        addLine(msg.text, msg.color)
        wait(msg.delay or 0.15)
    end
    
    -- Injection with progress bars
    for _, msg in ipairs(injectionSequence) do
        if msg.progress then
            addLine(msg.text, msg.color)
            wait(0.2)
            local bar = createProgressBar(msg.label .. ":")
            for i = 0, 100, math.random(3, 8) do
                bar.update(math.min(i, 100) / 100)
                wait(0.03)
            end
            bar.update(1)
            wait(0.1)
        else
            addLine(msg.text, msg.color)
            wait(msg.delay or 0.1)
        end
    end
    
    wait(0.3)
    
    -- Final sequence
    for _, msg in ipairs(finalSequence) do
        addLine(msg.text, msg.color)
        wait(msg.delay or 0.15)
    end
    
    wait(2)
    
    -- Fade out
    TweenService:Create(mainFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(terminal, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    for _, child in pairs(terminal:GetDescendants()) do
        pcall(function()
            TweenService:Create(child, TweenInfo.new(0.8), {
                BackgroundTransparency = 1,
                TextTransparency = 1
            }):Play()
        end)
    end
    
    wait(1)
    
    -- Cleanup and execute
    screenGui:Destroy()
    
    -- Execute the actual script
    loadstring(game:HttpGet([[https://raw.githubusercontent.com/xqtz/xqtz-Core/refs/heads/main/Arms%20of%20Conquest%20admin%20menu]]))()
end)

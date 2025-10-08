-- Load the library from the URL
local SharpUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ByxCommunityZz6/GstLib/refs/heads/main/Gst.lua"))()

-- Create the main GUI
local UI = SharpUI:New("Ghost Hub v1.2")

-- Add a Player tab
local PlayerTab = UI:AddTab("Player")

-- Example: Button to run a specific script
UI:AddButton(PlayerTab, "Run Fly Script", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end)
end)

-- Example: TextBox to enter a player name
UI:AddTextBox(PlayerTab, "Enter Player Name", function(text)
    print("Player Name entered:", text)
end)

-- Add a Scripts tab
local ScriptsTab = UI:AddTab("Scripts")

local scriptsList = {
    {Name = "ESP Script", URL = "https://pastebin.com/raw/cxYZp5wY"},
    {Name = "Dark Spawner", URL = "https://raw.githubusercontent.com/iwantsom3/script/refs/heads/main/Gag"}
}

for _, s in ipairs(scriptsList) do
    UI:AddButton(ScriptsTab, s.Name, function()
        pcall(function()
            loadstring(game:HttpGet(s.URL))()
        end)
    end)
end

-- Add an Execute tab
local ExecuteTab = UI:AddTab("GST Execute")

local editor = UI:AddTextBox(ExecuteTab, "Write your script here...", function(text)
    -- Nothing here, just a placeholder
end)

UI:AddButton(ExecuteTab, "Execute Script", function()
    if editor.Text ~= "" then
        pcall(function()
            loadstring(editor.Text)()
        end)
    end
end)

print("Ghost Hub GUI loaded successfully!")

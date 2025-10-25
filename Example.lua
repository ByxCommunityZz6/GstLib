-- Load Gst Library
local GstLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ByxCommunityZz6/GstLib/refs/heads/main/Gst.lua"))()

-- Create main window
local Window = GstLib:New("Gst Example | Bytox")

-- Create main tab
local Tab = Window:AddTab("Main")

-- Default image ID
local imageId = "rbxassetid://13497010343"

-- Add image to UI
local Image = GstLib:AddImage(Tab, imageId)

-- Textbox to change the image ID
GstLib:AddBox(Tab, "Enter Image ID", function(text)
	imageId = "rbxassetid://"..text
	Image.Image = imageId -- Update image instantly
end)

-- Simple button
GstLib:AddButton(Tab, "Print Current Image ID", function()
	print("Current Image ID:", imageId)
end)

-- Dropdown example
GstLib:AddDropdown(Tab, "Choose Option", {"Option 1", "Option 2", "Option 3"}, function(selected)
	print("Selected:", selected)
end)

-- Slider example
GstLib:AddSlider(Tab, "Speed", 0, 100, 50, function(val)
	print("Speed value:", val)
end)

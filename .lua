--// Note: This is WindUI, not a custom gui library by phantom flux.

local Library = {}
Library.__index = Library
Library.Async = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local UI = Library.Async
Library.Window = nil

--// Setup Main Window
function Library:Setup()
	local version = (getgenv and getgenv().LRM_ScriptVersion) and ("v" .. tostring(getgenv().LRM_ScriptVersion)) or "Dev Version"

	self.Window = UI:CreateWindow({
		Title = "Bytox Hub v1.8",
		Icon = "rbxassetid://80386265546973",
		Author = (getgenv().premium and "Premium" or "Grow a Garden") .. " | " .. version,
		Folder = "BytoxHub",
		Size = UDim2.fromOffset(580, 460),
		Transparent = true,
		Theme = "Dark",
		Resizable = true,
		SideBarWidth = 200,
		Background = "",
		BackgroundImageTransparency = 0.42,
		HideSearchBar = true,
		ScrollBarEnabled = false,
		User = {
			Enabled = true,
			Anonymous = false,
			Callback = function()
				print("clicked profile")
			end,
		},
	})

	return self.Window
end

--// Tab Creation
function Library:CreateTab(Name, Icon)
	local Window = self.Window or self:Setup()
	if not Window then error("[Library]: Failed to create window") return end

	local Tab = Window:Tab({
		Title = Name,
		Icon = Icon,
		Locked = false,
	})
	return Tab
end

--// Section Creation
function Library:CreateSection(Tab, Title, Size)
	return Tab:Section({
		Title = Title,
		TextXAlignment = "Left",
		TextSize = Size or 17,
	})
end

--// UI Element Helpers
function Library:CreateToggle(Tab, Table) return Tab:Toggle(Table) end
function Library:CreateButton(Tab, Table) return Tab:Button(Table) end
function Library:CreateSlider(Tab, Table) return Tab:Slider(Table) end
function Library:CreateDropdown(Tab, Table) return Tab:Dropdown(Table) end
function Library:CreateInput(Tab, Table) return Tab:Input(Table) end

--// Simple Notification Wrapper
function Library:Notify(data)
	if UI and UI.Notify then
		UI:Notify(data)
	else
		print("[Bytox Notify]:", data.Title or "Notice", data.Content or "")
	end
end

--// Special Setup: About Us Tab
function Library:SetupAboutUs(AboutUs)
	local Window = self.Window or self:Setup()
	if not Window then error("[Library]: Failed to find Window") return end

	AboutUs:Paragraph({
		Title = "Discord Invites",
		Icon = "discord",
		Desc = "Join our communities for updates and support!",
	})

	AboutUs:Button({
		Title = "Discord Link (Click to Copy)",
		Icon = "link",
		Callback = function()
			setclipboard("https://discord.gg/RHw9NSpqD")
			self:Notify({
				Title = "Copied!",
				Content = "Discord link copied!",
				Duration = 3,
			})
		end,
	})
end

return Library

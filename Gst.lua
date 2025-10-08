--// Sharp Black & White GUI Library | By Bytox
local SharpUI = {}
SharpUI.__index = SharpUI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")

-- Helper function لإنشاء العناصر بسرعة
local function Create(class, props)
    local obj = Instance.new(class)
    for k,v in pairs(props or {}) do
        if k ~= "Parent" then
            obj[k] = v
        end
    end
    if props and props.Parent then
        obj.Parent = props.Parent
    end
    return obj
end

-- دالة لإنشاء GUI رئيسي
function SharpUI:New(title)
    local selfObj = setmetatable({}, SharpUI)
    
    -- ScreenGui
    selfObj.ScreenGui = Create("ScreenGui", {Parent = game.CoreGui, Name = "SharpUI"})
    
    -- Main Frame
    selfObj.MainFrame = Create("Frame", {
        Parent = selfObj.ScreenGui,
        Size = UDim2.new(0, 550, 0, 350),
        Position = UDim2.new(0.5, -275, 0.5, -175),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 2,
        Active = true,
        Draggable = true
    })
    
    -- Title
    selfObj.Title = Create("TextLabel", {
        Parent = selfObj.MainFrame,
        Size = UDim2.new(1,0,0,40),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 2,
        Text = title or "Ghost Hub",
        TextColor3 = Color3.fromRGB(255,255,255),
        Font = Enum.Font.SourceSansBold,
        TextSize = 20
    })
    
    -- Hide Button
    selfObj.HideButton = Create("ImageButton", {
        Parent = selfObj.ScreenGui,
        Size = UDim2.new(0,40,0,40),
        Position = UDim2.new(1,-60,1,-60),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 2,
        Image = "rbxassetid://89313692535877",
        ZIndex = 10
    })
    
    local visible = true
    selfObj.HideButton.MouseButton1Click:Connect(function()
        visible = not visible
        selfObj.MainFrame.Visible = visible
    end)
    
    -- Tab List
    selfObj.TabList = Create("Frame", {
        Parent = selfObj.MainFrame,
        Position = UDim2.new(0,0,0,40),
        Size = UDim2.new(0,130,1,-40),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 2
    })
    
    Create("UIListLayout", {Parent = selfObj.TabList, Padding = UDim.new(0,5), SortOrder = Enum.SortOrder.LayoutOrder, FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Center})
    
    -- Content Frame
    selfObj.Content = Create("Frame", {
        Parent = selfObj.MainFrame,
        Position = UDim2.new(0,130,0,40),
        Size = UDim2.new(1,-130,1,-40),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 2,
        ClipsDescendants = true
    })
    
    selfObj.Tabs = {}
    return selfObj
end

-- دالة لإنشاء تبويب
function SharpUI:AddTab(name)
    local button = Create("TextButton", {
        Parent = self.TabList,
        Size = UDim2.new(1,-10,0,35),
        Text = name,
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 2,
        TextColor3 = Color3.fromRGB(255,255,255),
        Font = Enum.Font.SourceSansBold,
        TextSize = 17
    })
    
    local scroll = Create("ScrollingFrame", {
        Parent = self.Content,
        Size = UDim2.new(1,0,1,0),
        CanvasSize = UDim2.new(0,0,0,0),
        ScrollBarThickness = 8,
        ScrollBarImageColor3 = Color3.fromRGB(255,255,255),
        BackgroundTransparency = 1,
        Visible = false
    })
    
    local list = Create("UIListLayout", {Parent = scroll, Padding = UDim.new(0,10), SortOrder = Enum.SortOrder.LayoutOrder})
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0,0,0,list.AbsoluteContentSize.Y + 20)
    end)
    
    button.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Content:GetChildren()) do
            if t:IsA("ScrollingFrame") then t.Visible = false end
        end
        scroll.Visible = true
    end)
    
    self.Tabs[name] = scroll
    return scroll
end

-- دالة لإنشاء زر داخل تبويب
function SharpUI:AddButton(tab, text, callback)
    local Btn = Create("TextButton", {
        Parent = tab,
        Size = UDim2.new(1,0,0,40),
        Text = text,
        Font = Enum.Font.SourceSansBold,
        TextSize = 16,
        TextColor3 = Color3.fromRGB(255,255,255),
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 2
    })
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

-- دالة لإنشاء TextBox داخل تبويب
function SharpUI:AddTextBox(tab, placeholder, callback)
    local box = Create("TextBox", {
        Parent = tab,
        Size = UDim2.new(1,0,0,30),
        PlaceholderText = placeholder,
        BackgroundColor3 = Color3.fromRGB(0,0,0),
        BorderColor3 = Color3.fromRGB(255,255,255),
        TextColor3 = Color3.fromRGB(255,255,255),
        ClearTextOnFocus = false,
        Font = Enum.Font.SourceSans,
        TextSize = 16
    })
    box.FocusLost:Connect(function(enter)
        if enter then
            callback(box.Text)
        end
    end)
    return box
end

-- Example: Usage
--[[
local UI = SharpUI:New("Ghost Hub v1.2")
local playerTab = UI:AddTab("Player")
UI:AddButton(playerTab, "Run Script", function()
    print("Button clicked!")
end)
UI:AddTextBox(playerTab, "Enter Name", function(text)
    print("TextBox:", text)
end)
]]

return SharpUI

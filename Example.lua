local Fluriore = loadstring(game:HttpGet("https://raw.githubusercontent.com/hdgsydgdgdy1233/NexaUiLIB/refs/heads/main/FlurioreLib.lua"))()

-- Window
local Window = Fluriore:CreateWindow({
    Title = "My Super Hub",
    Icon = "door-open",
    Author = "by .ftgs and .ftgs",
    Folder = "MySuperHub",

    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,

    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("User icon clicked")
        end,
    },
})

-- Tab
local Tab = Window:Tab({
    Title = "Main",
    Icon = "bird",
    Locked = false,
})
Tab:Select()

-- Section
local Section = Tab:Section({
    Title = "Example Section",
    opened = true
})

-- Button
local Button = Tab:Button({
    Title = "Button",
    Desc = "Test Button",
    Locked = false,
    Callback = function()
        print("Button Clicked")
    end
})

-- Dropdown Multi
local DropdownMulti = Tab:Dropdown({
    Title = "Dropdown (Multi)",
    Desc = "Dropdown Description",
    Values = { "Category A", "Category B", "Category C" },
    Value = { "Category A" },
    Multi = true,
    AllowNone = true,
    Callback = function(option)
        print("Selected: ", game:GetService("HttpService"):JSONEncode(option))
    end,
})

-- Dropdown Single
local DropdownSingle = Tab:Dropdown({
    Title = "Dropdown",
    Desc = "Dropdown Description",
    Values = { "Category A", "Category B", "Category C" },
    Value = "Category A",
    Callback = function(option)
        print("Selected:", option)
    end,
})

-- Advanced Dropdown
local AdvancedDropdown = Tab:Dropdown({
    Title = "Advanced Dropdown",
    Desc = "Dropdown Description",
    Values = {
        { Title = "Category A", Icon = "bird" },
        { Title = "Category B", Icon = "house" },
        { Title = "Category C", Icon = "droplet" },
    },
    Value = "Category A",
    Callback = function(option)
        print("Selected:", option.Title, "Icon:", option.Icon)
    end
})

-- Input
local Input = Tab:Input({
    Title = "Input",
    Desc = "Input Description",
    Value = "",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "Enter text...",
    Callback = function(txt)
        print("Input:", txt)
    end,
})

-- Keybind
local Keybind = Tab:Keybind({
    Title = "Keybind",
    Desc = "Keybind to open ui",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

-- Paragraph
local Paragraph = Tab:Paragraph({
    Title = "Paragraph Example",
    Desc = "Test Paragraph",
    Color = "Red",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "bird",
            Title = "Button",
            Callback = function() print("Paragraph Button 1") end,
        }
    }
})

-- Slider
local Slider = Tab:Slider({
    Title = "Slider",
    Desc = "Slider Description",
    Step = 1,
    Value = {
        Min = 20,
        Max = 120,
        Default = 70,
    },
    Callback = function(v)
        print("Slider:", v)
    end
})

-- Toggle
local Toggle = Tab:Toggle({
    Title = "Toggle",
    Desc = "Toggle Description",
    Value = false,
    Callback = function(state)
        print("Toggle:", state)
    end,
})

-- Toggle + Icon + Checkbox
local Toggle2 = Tab:Toggle({
    Title = "Toggle With Icon",
    Desc = "Toggle Description",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        print("Toggle2:", state)
    end,
})

-- Notify
Fluriore:Notify({
    Title = "Welcome!",
    Content = "UI Loaded Successfully!",
    Duration = 3,
    Icon = "bird",
})

Tab:Space()

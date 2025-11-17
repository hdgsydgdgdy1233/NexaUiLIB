-- FlurioreLibFix.lua
-- Wrapper adapter that exposes the modern API described by the user
-- It wraps a base Fluriore library (which must expose MakeGui and MakeNotify)
-- Usage: local Fluriore = loadstring(game:HttpGet("URL_TO_THIS_FILE"))()

local FlurioreFix = {}

-- Try to get underlying base lib. If user previously loaded one as `FlurioreLib` or `Fluriore` use it,
-- otherwise expect the base to be provided via `opts.Base` when calling CreateWindow.
local function resolve_base(base)
    if base and type(base) == "table" then return base end
    if rawget(_G, "FlurioreLib") and type(_G.FlurioreLib) == "table" then return _G.FlurioreLib end
    if rawget(_G, "Fluriore") and type(_G.Fluriore) == "table" then return _G.Fluriore end
    return nil
end

-- Utility: safe call
local function safe_call(fn, ...)
    if type(fn) == "function" then
        local ok, r = pcall(fn, ...)
        if not ok then warn("FlurioreFix: callback error", r) end
        return r
    end
end

-- CreateWindow: returns an object with Tab, Notify, SetToggleKey etc.
function FlurioreFix:CreateWindow(opts)
    opts = opts or {}
    local base = resolve_base(opts.Base)
    if not base then
        error("FlurioreFix: underlying Fluriore library not found. Please load the original FlurioreLib before this wrapper.")
    end

    -- Map the simple window config to underlying MakeGui
    local guiConfig = {
        NameHub = opts.Title or opts.Name or "Fluriore UI",
        Description = opts.Author or opts.Description or "Fluriore",
        Color = opts.Color or Color3.fromRGB(255,0,255),
        ["Logo Player"] = opts["Logo Player"] or opts.Logo or ("https://www.roblox.com/headshot-thumbnail/image?userId="..game:GetService("Players").LocalPlayer.UserId.."&width=420&height=420&format=png"),
        ["Name Player"] = opts["Name Player"] or game:GetService("Players").LocalPlayer.Name,
        ["Tab Width"] = opts.SideBarWidth or opts["Tab Width"] or 125
    }

    local gui = base.MakeGui and base:MakeGui(guiConfig) or base.MakeGui(guiConfig)

    local Window = {}
    Window._gui = gui
    Window._tabs = {}
    Window._toggleKey = Enum.KeyCode.RightShift

    function Window:SetToggleKey(kc)
        if typeof(kc) == "EnumItem" then
            Window._toggleKey = kc
            return
        end
        if type(kc) == "string" then
            local ok, enum = pcall(function() return Enum.KeyCode[kc] end)
            if ok and enum then Window._toggleKey = enum end
        end
    end

    function Window:Tab(tabOpts)
        tabOpts = tabOpts or {}
        local t = gui:CreateTab({ Name = tabOpts.Title or tabOpts.Name or "Tab", Icon = tabOpts.Icon or "" })
        local publicTab = {}
        publicTab._tab = t

        function publicTab:Select()
            safe_call(function() t:Select() end)
        end

        function publicTab:Section(sectionOpts)
            -- keep compatibility with Section({Title, opened}) used in example
            local sec = t:AddSection(sectionOpts.Title or sectionOpts.Title or "Section")
            return sec
        end

        -- Button
        function publicTab:Button(opt)
            opt = opt or {}
            local btn = t:AddButton({ Title = opt.Title or opt.name or "Button", Content = opt.Desc or opt.Desc or "", Icon = opt.Icon or "", Callback = opt.Callback })
            return btn
        end

        -- Dropdown
        function publicTab:Dropdown(opt)
            opt = opt or {}
            local cfg = {
                Title = opt.Title or "Dropdown",
                Content = opt.Desc or opt.Desc or "",
                Multi = opt.Multi or false,
                Options = opt.Values or opt.Options or {},
                Default = (opt.Multi and opt.Value) or (not opt.Multi and ({opt.Value}) or opt.Value) or {}
            }
            local dd = t:AddDropdown({ Title = cfg.Title, Content = cfg.Content, Multi = cfg.Multi, Options = cfg.Options, Default = cfg.Default, Callback = opt.Callback })
            -- Provide helper methods similar to example
            local proxy = {}
            proxy.Set = function(v)
                if dd.Set then dd:Set(v) end
            end
            proxy.Add = function(v) if dd.AddOption then dd:AddOption(v) end end
            proxy.Clear = function() if dd.Clear then dd:Clear() end end
            proxy.Refresh = function(list, selecting) if dd.Refresh then dd:Refresh(list, selecting) end end
            proxy.Value = dd.Value or {}
            proxy.Options = dd.Options or cfg.Options
            return proxy
        end

        -- Input
        function publicTab:Input(opt)
            opt = opt or {}
            local input = t:AddInput({ Title = opt.Title or "Input", Content = opt.Desc or "", Default = opt.Value or opt.Value or "", Callback = opt.Callback })
            return input
        end

        -- Keybind
        function publicTab:Keybind(opt)
            opt = opt or {}
            local key = opt.Value or "G"
            local kb = t:AddKeybind({ Title = opt.Title or "Keybind", Desc = opt.Desc or "", Value = key, Callback = opt.Callback })
            return kb
        end

        -- Paragraph
        function publicTab:Paragraph(opt)
            opt = opt or {}
            local p = t:AddParagraph({ Title = opt.Title or "Paragraph", Content = opt.Desc or opt.Desc or "", Color = opt.Color, Image = opt.Image, ImageSize = opt.ImageSize, Thumbnail = opt.Thumbnail, ThumbnailSize = opt.ThumbnailSize, Buttons = opt.Buttons })
            return p
        end

        -- Slider
        function publicTab:Slider(opt)
            opt = opt or {}
            local cfg = opt.Value or { Min = opt.Min or 0, Max = opt.Max or 100, Default = opt.Default or opt.Value or 0 }
            local s = t:AddSlider({ Title = opt.Title or "Slider", Content = opt.Desc or "", Min = cfg.Min, Max = cfg.Max, Increment = opt.Step or 1, Default = cfg.Default, Callback = opt.Callback })
            return s
        end

        -- Toggle
        function publicTab:Toggle(opt)
            opt = opt or {}
            local toggle = t:AddToggle({ Title = opt.Title or "Toggle", Content = opt.Desc or "", Default = opt.Value or false, Callback = opt.Callback, Icon = opt.Icon, Type = opt.Type })
            return toggle
        end

        function publicTab:Space() if t.Space then t:Space() end end

        return publicTab
    end

    function Window:SetTheme(themeName)
        -- underlying lib might not support theme; noop
        warn("FlurioreFix: SetTheme is a noop unless underlying lib supports it")
    end

    -- Expose Notify via base.MakeNotify or base:MakeNotify
    function FlurioreFix:Notify(opts)
        opts = opts or {}
        local nf = base.MakeNotify and base:MakeNotify({ Title = opts.Title or opts.Title, Description = opts.Description or "", Content = opts.Content or "", Color = opts.Color or Color3.fromRGB(255,0,255), Time = opts.Time or 0.5, Delay = opts.Duration or opts.Delay or 3 })
        return nf
    end

    -- return Window proxy
    return Window
end

return FlurioreFix

--// ADAPTADOR FROGGY HUB -> TAYHUB API
local DESIGN_URL = "https://raw.githubusercontent.com/cristhiandalmauquintana-ctrl/Whitefantasy/main/design.lua"
local ASSETS_URL = "https://raw.githubusercontent.com/cristhiandalmauquintana-ctrl/Whitefantasy/main/assets.lua"

local UI_Library = loadstring(game:HttpGet(DESIGN_URL))()
local Assets = loadstring(game:HttpGet(ASSETS_URL))()

local RealWindow = UI_Library.CreateWindow({ Title = "FROGGY HUB", Subtitle = "POWERED BY TAYHUB" })
Assets.Extend(RealWindow)

local Library = {}
local Tabs = {}

-- 1. Crear Ventana
function Library:Window(Args)
    if Args then
        RealWindow:SetTitle(Args.Title or "FROGGY HUB", Args.SubTitle or "TAYHUB EDITION")
    end
    
    local WindowProxy = {}
    
    -- 2. Crear Pestañas (Pages)
    function WindowProxy:NewPage(Args)
        local tabName = Args and (Args.Title or Args.Name) or "TAB"
        local tab = RealWindow:CreateTab(tabName)
        
        local PageProxy = {}
        
        -- 3. Traducir Secciones
        function PageProxy:Section(Text)
            tab:AddSection(Text)
        end
        
        -- 4. Traducir Botones
        function PageProxy:Button(Args)
            local title = Args.Title or "Button"
            local text = Args.Text or title
            local callback = Args.Callback or function() end
            tab:AddButton(text, callback)
            return { MouseButton1Click = { Connect = function() end } } -- Retornamos un objeto falso para que Luraph no explote
        end
        
        -- 5. Traducir Toggles
        function PageProxy:Toggle(Args)
            local title = Args.Title or "Toggle"
            local value = Args.Value or false
            local callback = Args.Callback or function() end
            tab:AddToggle(title, value, callback)
            return {} -- Retorno falso
        end
        
        -- 6. Traducir Sliders
        function PageProxy:Slider(Args)
            local title = Args.Title or "Slider"
            local min = Args.Min or 0
            local max = Args.Max or 100
            local value = Args.Value or min
            local callback = Args.Callback or function() end
            tab:AddSlider(title, min, max, value, callback, 1)
            return {} -- Retorno falso
        end
        
        -- 7. Traducir Dropdowns
        function PageProxy:Dropdown(Args)
            local title = Args.Title or "Dropdown"
            local options = Args.Options or {}
            local default = Args.Default or options[1]
            local callback = Args.Callback or function() end
            tab:AddDropdown(title, options, default, callback)
            return {}
        end
        
        -- 8. Traducir Textbox
        function PageProxy:Textbox(Args)
            local title = Args.Title or "Input"
            local placeholder = Args.Placeholder or ""
            local callback = Args.Callback or function() end
            tab:AddTextbox(title, "", placeholder, callback)
            return {}
        end
        
        -- 9. Traducir Paragraph (Información)
        function PageProxy:Paragraph(Args)
            local title = Args.Title or "Info"
            local desc = Args.Desc or ""
            tab:AddInfo(title, desc)
            return {}
        end
        
        -- Alias
        PageProxy.Select = PageProxy.Dropdown
        PageProxy.Input = PageProxy.Textbox
        
        return PageProxy
    end
    
    return WindowProxy
end

-- Funciones falsas para evitar errores de Luraph
function Library:SetTimeValue(val) end
function Library:Parent() return nil end
function Library:Create(Class, Props) 
    local inst = Instance.new(Class)
    for k, v in pairs(Props or {}) do inst[k] = v end
    return inst 
end
function Library:Draggable() end
function Library:Button(Parent) return Instance.new("TextButton") end
function Library:Tween() return {Play = function() end} end
function Library.Effect() end
function Library:Asset() end
function Library:NewRows() end
function Library:IsDropdownOpen() return false end

return Library

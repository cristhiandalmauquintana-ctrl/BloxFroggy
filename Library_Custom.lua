--// ADAPTADOR ESTRICTO FROGGY HUB -> TAYHUB API
local DESIGN_URL = "https://raw.githubusercontent.com/cristhiandalmauquintana-ctrl/Whitefantasy/main/design.lua"
local UI_Library = loadstring(game:HttpGet(DESIGN_URL))()
local RealWindow = UI_Library.CreateWindow({ Title = "FROGGY HUB", Subtitle = "POWERED BY TAYHUB" })

print("[Froggy Adapter] ¡Librería cargada por Luraph!")

local Library = {}

-- Función maestra para crear la ventana
function Library:Window(Args)
    print("[Froggy Adapter] Ventana solicitada.")
    local WindowProxy = {}
    
    -- Luraph suele usar NewPage o Tab
    function WindowProxy:NewPage(Args)
        local title = Args and (Args.Title or Args.Name) or "TAB"
        print("[Froggy Adapter] Creando Pestaña: " .. tostring(title))
        local tab = RealWindow:CreateTab(title)
        local PageProxy = {}
        
        function PageProxy:Section(Text)
            print("[Froggy Adapter] Sección: " .. tostring(Text))
            tab:AddSection(tostring(Text))
        end
        
        function PageProxy:Button(Args)
            local t = Args and (Args.Title or Args.Text) or "Button"
            print("[Froggy Adapter] Botón: " .. tostring(t))
            tab:AddButton(t, Args.Callback or function() end)
            return {} -- Retorno falso
        end
        
        function PageProxy:Toggle(Args)
            local t = Args and (Args.Title or Args.Name) or "Toggle"
            print("[Froggy Adapter] Toggle: " .. tostring(t))
            tab:AddToggle(t, Args.Value or false, Args.Callback or function() end)
            return {} -- Retorno falso
        end
        
        function PageProxy:Slider(Args)
            local t = Args and (Args.Title or Args.Name) or "Slider"
            print("[Froggy Adapter] Slider: " .. tostring(t))
            tab:AddSlider(t, Args.Min or 0, Args.Max or 100, Args.Value or 0, Args.Callback or function() end)
            return {} -- Retorno falso
        end
        
        function PageProxy:Dropdown(Args)
            local t = Args and (Args.Title or Args.Name) or "Dropdown"
            print("[Froggy Adapter] Dropdown: " .. tostring(t))
            tab:AddDropdown(t, Args.Options or {}, Args.Default, Args.Callback or function() end)
            return {} -- Retorno falso
        end
        
        function PageProxy:Paragraph(Args)
            local t = Args and (Args.Title or Args.Name) or "Info"
            print("[Froggy Adapter] Paragraph: " .. tostring(t))
            tab:AddInfo(t, Args.Desc or "")
            return {}
        end
        
        function PageProxy:Textbox(Args)
            print("[Froggy Adapter] Textbox")
            tab:AddTextbox(Args.Title or "Input", "", Args.Placeholder or "", Args.Callback or function() end)
            return {}
        end
        
        return PageProxy
    end
    
    -- Alias por si Luraph usa Window:Tab()
    WindowProxy.Tab = WindowProxy.NewPage
    
    return WindowProxy
end

-- Alias por si Luraph usa Library:CreateWindow()
Library.CreateWindow = Library.Window

-- Retornamos la librería
return Library

-- except bugs on rbxcli.
-- current bugs: menu bind, keybind stuff mb idk... i cant m2 for some reason, ehh who cares!

-- This gui is fully vibecoded!!
-- i will appreciate anyone that will fork this ui, but please, indicate who created this �
-- nyanwolf.net ^_^

local RunService      = game:GetService("RunService")
local UserInputSvc    = game:GetService("UserInputService")

local FONT_SIZE   = 14
local FONT_SIZE_S = 12
local FD          = font.get_font_descriptor("Arial", FONT_SIZE)
local FD_S        = font.get_font_descriptor("Arial", FONT_SIZE_S)

local function measure(text, fd)
    local ch_w = (fd == FD) and 8 or 7
    local ch_h = (fd == FD) and 14 or 12
    return #text * ch_w, ch_h
end

local function c4(t)
    return Color4.new(t[1], t[2], t[3], t[4] or 1)
end

local THEMES = {
    ["Dark"] = {
        bg          = {0.03, 0.03, 0.03, 0.98},
        panel       = {0.05, 0.05, 0.05, 1.00},
        panel_dark  = {0.02, 0.02, 0.02, 1.00},
        header      = {0.04, 0.04, 0.04, 1.00},
        tab_active  = {0.08, 0.08, 0.08, 1.00},
        tab_idle    = {0.04, 0.04, 0.04, 1.00},
        sel_active  = {0.07, 0.07, 0.07, 1.00},
        sel_hover   = {0.06, 0.06, 0.06, 1.00},
        section_hdr = {0.08, 0.08, 0.08, 1.00},
        border_l    = {0.18, 0.18, 0.18, 1.00},
        border_r    = {0.12, 0.12, 0.12, 1.00},
        accent      = {0.90, 0.90, 0.90, 1.00},
        text        = {0.75, 0.75, 0.75, 1.00},
        text_dim    = {0.35, 0.35, 0.35, 1.00},
        text_active = {1.00, 1.00, 1.00, 1.00},
        chk_on      = {0.85, 0.85, 0.85, 1.00},
        chk_off     = {0.07, 0.07, 0.07, 1.00},
        chk_border  = {0.22, 0.22, 0.22, 1.00},
        slider_bg   = {0.07, 0.07, 0.07, 1.00},
        slider_fill = {0.80, 0.80, 0.80, 1.00},
        btn_bg      = {0.08, 0.08, 0.08, 1.00},
        btn_hov     = {0.13, 0.13, 0.13, 1.00},
        input_bg    = {0.07, 0.07, 0.07, 1.00},
        dropdown_bg = {0.05, 0.05, 0.05, 1.00},
        dropdown_hov= {0.10, 0.10, 0.10, 1.00},
        separator   = {0.14, 0.14, 0.14, 1.00},
        title_text  = {0.50, 0.50, 0.50, 1.00},
        wm_bg       = {0.03, 0.03, 0.03, 0.92},
        wm_border   = {0.18, 0.18, 0.18, 1.00},
        wm_text     = {0.85, 0.85, 0.85, 1.00},
        hk_bg       = {0.03, 0.03, 0.03, 0.92},
        hk_border   = {0.18, 0.18, 0.18, 1.00},
        hk_header   = {0.07, 0.07, 0.07, 1.00},
        hk_text     = {0.75, 0.75, 0.75, 1.00},
        hk_title    = {0.90, 0.90, 0.90, 1.00},
        ctx_bg      = {0.06, 0.06, 0.06, 0.98},
        ctx_border  = {0.20, 0.20, 0.20, 1.00},
        ctx_hov     = {0.12, 0.12, 0.12, 1.00},
        ctx_text    = {0.80, 0.80, 0.80, 1.00},
        ctx_active  = {1.00, 1.00, 1.00, 1.00},
    },
    ["Forest"] = {
        bg          = {0.08, 0.08, 0.06, 0.98},
        panel       = {0.12, 0.12, 0.09, 1.00},
        panel_dark  = {0.06, 0.06, 0.04, 1.00},
        header      = {0.10, 0.11, 0.07, 1.00},
        tab_active  = {0.15, 0.16, 0.11, 1.00},
        tab_idle    = {0.09, 0.09, 0.06, 1.00},
        sel_active  = {0.14, 0.15, 0.10, 1.00},
        sel_hover   = {0.12, 0.13, 0.09, 1.00},
        section_hdr = {0.33, 0.39, 0.27, 1.00},
        border_l    = {0.49, 0.60, 0.43, 1.00},
        border_r    = {0.33, 0.39, 0.27, 1.00},
        accent      = {0.49, 0.60, 0.43, 1.00},
        text        = {0.95, 0.95, 0.93, 1.00},
        text_dim    = {0.55, 0.58, 0.50, 1.00},
        text_active = {0.95, 0.95, 0.93, 1.00},
        chk_on      = {0.49, 0.60, 0.43, 1.00},
        chk_off     = {0.12, 0.14, 0.09, 1.00},
        chk_border  = {0.33, 0.39, 0.27, 1.00},
        slider_bg   = {0.12, 0.14, 0.09, 1.00},
        slider_fill = {0.49, 0.60, 0.43, 1.00},
        btn_bg      = {0.15, 0.18, 0.11, 1.00},
        btn_hov     = {0.22, 0.26, 0.17, 1.00},
        input_bg    = {0.12, 0.14, 0.09, 1.00},
        dropdown_bg = {0.09, 0.10, 0.07, 1.00},
        dropdown_hov= {0.18, 0.20, 0.13, 1.00},
        separator   = {0.25, 0.28, 0.19, 1.00},
        title_text  = {0.67, 0.70, 0.60, 1.00},
        wm_bg       = {0.07, 0.08, 0.05, 0.92},
        wm_border   = {0.49, 0.60, 0.43, 1.00},
        wm_text     = {0.95, 0.95, 0.93, 1.00},
        hk_bg       = {0.07, 0.08, 0.05, 0.92},
        hk_border   = {0.49, 0.60, 0.43, 1.00},
        hk_header   = {0.33, 0.39, 0.27, 1.00},
        hk_text     = {0.95, 0.95, 0.93, 1.00},
        hk_title    = {0.49, 0.60, 0.43, 1.00},
        ctx_bg      = {0.08, 0.09, 0.06, 0.98},
        ctx_border  = {0.49, 0.60, 0.43, 1.00},
        ctx_hov     = {0.14, 0.16, 0.10, 1.00},
        ctx_text    = {0.85, 0.88, 0.80, 1.00},
        ctx_active  = {0.95, 0.95, 0.93, 1.00},
    },
    ["Ocean"] = {
        bg          = {0.04, 0.08, 0.13, 0.98},
        panel       = {0.06, 0.11, 0.18, 1.00},
        panel_dark  = {0.03, 0.06, 0.10, 1.00},
        header      = {0.05, 0.09, 0.15, 1.00},
        tab_active  = {0.08, 0.14, 0.22, 1.00},
        tab_idle    = {0.04, 0.08, 0.13, 1.00},
        sel_active  = {0.07, 0.13, 0.21, 1.00},
        sel_hover   = {0.06, 0.11, 0.18, 1.00},
        section_hdr = {0.07, 0.25, 0.40, 1.00},
        border_l    = {0.10, 0.55, 0.85, 1.00},
        border_r    = {0.05, 0.35, 0.65, 1.00},
        accent      = {0.10, 0.55, 0.85, 1.00},
        text        = {0.80, 0.92, 1.00, 1.00},
        text_dim    = {0.40, 0.55, 0.68, 1.00},
        text_active = {1.00, 1.00, 1.00, 1.00},
        chk_on      = {0.10, 0.55, 0.85, 1.00},
        chk_off     = {0.06, 0.12, 0.20, 1.00},
        chk_border  = {0.12, 0.35, 0.55, 1.00},
        slider_bg   = {0.06, 0.12, 0.20, 1.00},
        slider_fill = {0.10, 0.55, 0.85, 1.00},
        btn_bg      = {0.07, 0.16, 0.26, 1.00},
        btn_hov     = {0.10, 0.22, 0.35, 1.00},
        input_bg    = {0.06, 0.12, 0.20, 1.00},
        dropdown_bg = {0.05, 0.09, 0.15, 1.00},
        dropdown_hov= {0.09, 0.18, 0.29, 1.00},
        separator   = {0.10, 0.22, 0.35, 1.00},
        title_text  = {0.55, 0.78, 0.95, 1.00},
        wm_bg       = {0.04, 0.08, 0.14, 0.92},
        wm_border   = {0.10, 0.55, 0.85, 1.00},
        wm_text     = {0.80, 0.92, 1.00, 1.00},
        hk_bg       = {0.04, 0.08, 0.14, 0.92},
        hk_border   = {0.10, 0.55, 0.85, 1.00},
        hk_header   = {0.07, 0.25, 0.40, 1.00},
        hk_text     = {0.80, 0.92, 1.00, 1.00},
        hk_title    = {0.10, 0.55, 0.85, 1.00},
        ctx_bg      = {0.04, 0.09, 0.15, 0.98},
        ctx_border  = {0.10, 0.55, 0.85, 1.00},
        ctx_hov     = {0.08, 0.18, 0.28, 1.00},
        ctx_text    = {0.70, 0.85, 1.00, 1.00},
        ctx_active  = {1.00, 1.00, 1.00, 1.00},
    },
    ["Crimson"] = {
        bg          = {0.10, 0.05, 0.05, 0.98},
        panel       = {0.14, 0.07, 0.07, 1.00},
        panel_dark  = {0.07, 0.03, 0.03, 1.00},
        header      = {0.12, 0.06, 0.06, 1.00},
        tab_active  = {0.18, 0.09, 0.09, 1.00},
        tab_idle    = {0.11, 0.05, 0.05, 1.00},
        sel_active  = {0.17, 0.08, 0.08, 1.00},
        sel_hover   = {0.15, 0.07, 0.07, 1.00},
        section_hdr = {0.40, 0.08, 0.08, 1.00},
        border_l    = {0.80, 0.15, 0.15, 1.00},
        border_r    = {0.55, 0.10, 0.10, 1.00},
        accent      = {0.80, 0.15, 0.15, 1.00},
        text        = {0.95, 0.85, 0.85, 1.00},
        text_dim    = {0.58, 0.40, 0.40, 1.00},
        text_active = {1.00, 1.00, 1.00, 1.00},
        chk_on      = {0.75, 0.15, 0.15, 1.00},
        chk_off     = {0.16, 0.08, 0.08, 1.00},
        chk_border  = {0.45, 0.18, 0.18, 1.00},
        slider_bg   = {0.16, 0.08, 0.08, 1.00},
        slider_fill = {0.75, 0.15, 0.15, 1.00},
        btn_bg      = {0.20, 0.09, 0.09, 1.00},
        btn_hov     = {0.28, 0.13, 0.13, 1.00},
        input_bg    = {0.16, 0.08, 0.08, 1.00},
        dropdown_bg = {0.12, 0.06, 0.06, 1.00},
        dropdown_hov= {0.22, 0.10, 0.10, 1.00},
        separator   = {0.30, 0.12, 0.12, 1.00},
        title_text  = {0.85, 0.55, 0.55, 1.00},
        wm_bg       = {0.10, 0.04, 0.04, 0.92},
        wm_border   = {0.80, 0.15, 0.15, 1.00},
        wm_text     = {0.95, 0.85, 0.85, 1.00},
        hk_bg       = {0.10, 0.04, 0.04, 0.92},
        hk_border   = {0.80, 0.15, 0.15, 1.00},
        hk_header   = {0.40, 0.08, 0.08, 1.00},
        hk_text     = {0.95, 0.85, 0.85, 1.00},
        hk_title    = {0.80, 0.15, 0.15, 1.00},
        ctx_bg      = {0.12, 0.05, 0.05, 0.98},
        ctx_border  = {0.80, 0.15, 0.15, 1.00},
        ctx_hov     = {0.22, 0.08, 0.08, 1.00},
        ctx_text    = {0.95, 0.75, 0.75, 1.00},
        ctx_active  = {1.00, 1.00, 1.00, 1.00},
    },
    ["Midnight"] = {
        bg          = {0.05, 0.05, 0.08, 0.98},
        panel       = {0.08, 0.07, 0.12, 1.00},
        panel_dark  = {0.03, 0.03, 0.06, 1.00},
        header      = {0.07, 0.06, 0.11, 1.00},
        tab_active  = {0.11, 0.10, 0.17, 1.00},
        tab_idle    = {0.06, 0.05, 0.09, 1.00},
        sel_active  = {0.10, 0.09, 0.16, 1.00},
        sel_hover   = {0.09, 0.08, 0.14, 1.00},
        section_hdr = {0.18, 0.14, 0.32, 1.00},
        border_l    = {0.45, 0.35, 0.85, 1.00},
        border_r    = {0.25, 0.20, 0.60, 1.00},
        accent      = {0.45, 0.35, 0.85, 1.00},
        text        = {0.88, 0.86, 0.98, 1.00},
        text_dim    = {0.48, 0.45, 0.60, 1.00},
        text_active = {1.00, 1.00, 1.00, 1.00},
        chk_on      = {0.40, 0.30, 0.80, 1.00},
        chk_off     = {0.10, 0.09, 0.17, 1.00},
        chk_border  = {0.28, 0.25, 0.48, 1.00},
        slider_bg   = {0.10, 0.09, 0.17, 1.00},
        slider_fill = {0.40, 0.30, 0.80, 1.00},
        btn_bg      = {0.13, 0.12, 0.22, 1.00},
        btn_hov     = {0.18, 0.17, 0.30, 1.00},
        input_bg    = {0.10, 0.09, 0.17, 1.00},
        dropdown_bg = {0.07, 0.06, 0.12, 1.00},
        dropdown_hov= {0.15, 0.14, 0.25, 1.00},
        separator   = {0.18, 0.16, 0.30, 1.00},
        title_text  = {0.65, 0.60, 0.88, 1.00},
        wm_bg       = {0.05, 0.04, 0.09, 0.92},
        wm_border   = {0.45, 0.35, 0.85, 1.00},
        wm_text     = {0.88, 0.86, 0.98, 1.00},
        hk_bg       = {0.05, 0.04, 0.09, 0.92},
        hk_border   = {0.45, 0.35, 0.85, 1.00},
        hk_header   = {0.18, 0.14, 0.32, 1.00},
        hk_text     = {0.88, 0.86, 0.98, 1.00},
        hk_title    = {0.45, 0.35, 0.85, 1.00},
        ctx_bg      = {0.06, 0.05, 0.10, 0.98},
        ctx_border  = {0.45, 0.35, 0.85, 1.00},
        ctx_hov     = {0.14, 0.12, 0.24, 1.00},
        ctx_text    = {0.80, 0.78, 0.95, 1.00},
        ctx_active  = {1.00, 1.00, 1.00, 1.00},
    },
}

local THEME_NAMES   = {"Dark","Forest","Ocean","Crimson","Midnight"}
local current_theme = "Dark"
local C             = THEMES[current_theme]

local function apply_theme(name)
    current_theme = name
    C = THEMES[name]
end

local WIN_X  = 80
local WIN_Y  = 60
local WIN_W  = 760
local WIN_H  = 520
local TAB_H  = 34
local HDR_H  = 28
local ROW_H  = 24
local PAD_X  = 10
local PAD_Y  = 6
local CHK_SZ = 14
local SEC_H  = 22
local DD_ROW = 20

-- ── Глобальное состояние ввода ────────────────────────────────
local g_lmb      = false
local g_rmb      = false
local g_lmb_prev = false
local g_rmb_prev = false
local g_mx       = 0
local g_my       = 0

local menu_open  = true
local active_tab = 1
local active_sel = 1

local dragging = false
local drag_ox  = 0
local drag_oy  = 0

local wm_x        = 10
local wm_y        = 10
local wm_dragging = false
local wm_drag_ox  = 0
local wm_drag_oy  = 0

local hk_x        = nil
local hk_y        = nil
local hk_dragging = false
local hk_drag_ox  = 0
local hk_drag_oy  = 0

local drag_slider_id = nil
local menu_bind_vk   = Enum.KeyCode.Insert
local menu_bind_was  = false

local tabs = {"aimbot","visuals","misc"}

local cp_open    = false
local cp_elem_id = nil
local cp_drag_sv = false
local cp_drag_h  = false
local cp_drag_a  = false

local kb_listening_id = nil
local dd_open_id      = nil

local pending_colorpickers = {}
local pending_dropdowns    = {}

local ctx_open   = false
local ctx_hk_idx = nil
local ctx_x      = 0
local ctx_y      = 0
local CTX_MODES  = {"Always","Hold","Toggle"}
local CTX_ROW_H  = 22
local CTX_PAD_X  = 12
local CTX_PAD_Y  = 4

local VK_NAMES = {
    [Enum.KeyCode.LeftButton]   = "mouse1",
    [Enum.KeyCode.RightButton]  = "mouse2",
    [Enum.KeyCode.MiddleButton] = "mouse3",
    [Enum.KeyCode.Backspace]    = "back",
    [Enum.KeyCode.Tab]          = "tab",
    [Enum.KeyCode.Return]       = "enter",
    [Enum.KeyCode.Shift]        = "shift",
    [Enum.KeyCode.Control]      = "ctrl",
    [Enum.KeyCode.Alt]          = "alt",
    [Enum.KeyCode.Escape]       = "esc",
    [Enum.KeyCode.Space]        = "space",
    [Enum.KeyCode.Insert]       = "insert",
    [Enum.KeyCode.Delete]       = "delete",
    [Enum.KeyCode.F1]="f1",   [Enum.KeyCode.F2]="f2",
    [Enum.KeyCode.F3]="f3",   [Enum.KeyCode.F4]="f4",
    [Enum.KeyCode.F5]="f5",   [Enum.KeyCode.F6]="f6",
    [Enum.KeyCode.F7]="f7",   [Enum.KeyCode.F8]="f8",
    [Enum.KeyCode.F9]="f9",   [Enum.KeyCode.F10]="f10",
    [Enum.KeyCode.F11]="f11", [Enum.KeyCode.F12]="f12",
    [Enum.KeyCode.A]="a", [Enum.KeyCode.B]="b", [Enum.KeyCode.C]="c",
    [Enum.KeyCode.D]="d", [Enum.KeyCode.E]="e", [Enum.KeyCode.F]="f",
    [Enum.KeyCode.G]="g", [Enum.KeyCode.H]="h", [Enum.KeyCode.I]="i",
    [Enum.KeyCode.J]="j", [Enum.KeyCode.K]="k", [Enum.KeyCode.L]="l",
    [Enum.KeyCode.M]="m", [Enum.KeyCode.N]="n", [Enum.KeyCode.O]="o",
    [Enum.KeyCode.P]="p", [Enum.KeyCode.Q]="q", [Enum.KeyCode.R]="r",
    [Enum.KeyCode.S]="s", [Enum.KeyCode.T]="t", [Enum.KeyCode.U]="u",
    [Enum.KeyCode.V]="v", [Enum.KeyCode.W]="w", [Enum.KeyCode.X]="x",
    [Enum.KeyCode.Y]="y", [Enum.KeyCode.Z]="z",
    [Enum.KeyCode.Zero]="0",  [Enum.KeyCode.One]="1",
    [Enum.KeyCode.Two]="2",   [Enum.KeyCode.Three]="3",
    [Enum.KeyCode.Four]="4",  [Enum.KeyCode.Five]="5",
    [Enum.KeyCode.Six]="6",   [Enum.KeyCode.Seven]="7",
    [Enum.KeyCode.Eight]="8", [Enum.KeyCode.Nine]="9",
}

local VK_BY_NAME = {}
for kc, name in pairs(VK_NAMES) do VK_BY_NAME[name] = kc end

local ALL_KEYCODES = {}
for kc in pairs(VK_NAMES) do table.insert(ALL_KEYCODES, kc) end

local function vk_to_str(kc)
    return VK_NAMES[kc] or tostring(kc)
end
local function str_to_vk(s)
    if not s then return nil end
    return VK_BY_NAME[s:lower()] or nil
end

local function hsv_to_rgb(h,s,v)
    if s==0 then return v,v,v end
    h=h*6; local i=math.floor(h); local f=h-i
    local p=v*(1-s); local q=v*(1-s*f); local t=v*(1-s*(1-f))
    if i==0 then return v,t,p elseif i==1 then return q,v,p
    elseif i==2 then return p,v,t elseif i==3 then return p,q,v
    elseif i==4 then return t,p,v else return v,p,q end
end
local function rgb_to_hsv(r,g,b)
    local max=math.max(r,g,b); local min=math.min(r,g,b)
    local v=max; local s=max==0 and 0 or (max-min)/max; local h=0
    if max~=min then
        local d=max-min
        if max==r then h=(g-b)/d+(g<b and 6 or 0)
        elseif max==g then h=(b-r)/d+2 else h=(r-g)/d+4 end
        h=h/6
    end
    return h,s,v
end

local function mk_check(label,id,val)
    return {type="check",label=label,id=id,val=val}
end
local function mk_slider(label,id,val,mn,mx)
    return {type="slider",label=label,id=id,val=val,min=mn,max=mx}
end
local function mk_color(label,id,val)
    local r,g,b=val[1],val[2],val[3]; local h,s,v=rgb_to_hsv(r,g,b)
    return {type="color",label=label,id=id,val=val,h=h,s=s,v=v}
end
local function mk_btn(label,id,cb)
    return {type="button",label=label,id=id,cb=cb}
end
local function mk_input(label,id,val,is_keybind)
    return {type="input",label=label,id=id,val=val,is_keybind=is_keybind or false}
end
local function mk_label(label)
    return {type="label",label=label}
end
local function mk_sec(label)
    return {type="section",label=label}
end
local function mk_combo(label,id,items,default_idx)
    return {type="combo",label=label,id=id,items=items,val=default_idx or 1}
end
local function mk_multicombo(label,id,items,defaults)
    local v={}
    for i=1,#items do v[i]=defaults and (defaults[i] or false) or false end
    return {type="multicombo",label=label,id=id,items=items,val=v}
end

local tab_layouts = {
    [1] = {
        {
            mk_sec("aimbot"),
            mk_check("enabled",       "aim_on",        false),
            mk_input("key",           "aim_key_lbl",   "mouse2",true),
            mk_combo("mode",          "aim_mode",      {"Camera","Silent","Lerp"},1),
            mk_check("smoothness",    "aim_smooth_on", false),
            mk_check("sticky aim",    "aim_sticky",    false),
            mk_check("prediction",    "aim_pred",      false),
            mk_slider("prediction x", "aim_pred_x",    1,0,10),
            mk_slider("prediction z", "aim_pred_z",    1,0,10),
            mk_check("bullet drop",   "aim_bdrop",     false),
            mk_multicombo("hitboxes", "aim_hbox",      {"Head","Torso","Arms","Legs"},{true,true,false,false}),
            mk_combo("checks",        "aim_checks",    {"visible","all","team"},1),
            mk_check("draw fov",      "aim_drawfov",   false),
            mk_slider("fov radius",   "aim_fov",       80,10,400),
        },
        {
            mk_sec("triggerbot"),
            mk_check("enabled",       "tbot_on",       false),
            mk_input("key",           "tbot_key_lbl",  "mouse2",true),
            mk_check("radius",        "tbot_rad_on",   false),
            mk_slider("tbot radius",  "tbot_rad",      0,0,100),
            mk_check("duration",      "tbot_dur_on",   false),
            mk_slider("duration",     "tbot_dur",      3,0,20),
            mk_check("delay",         "tbot_del_on",   false),
            mk_label("delay - 5ms"),
            mk_multicombo("hitboxes", "tbot_hbox",     {"Head","Torso","Arms","Legs"},{true,true,false,false}),
            mk_combo("checks",        "tbot_checks",   {"visible","all","team"},1),
        },
    },
    [2] = {},
    [3] = {
        {
            mk_sec("misc"),
            mk_check("longneck",           "m_longneck",   false),
            mk_slider("longneck distance", "m_longneck_d", 5,0,100),
            mk_check("freecam",            "m_freecam",    false),
            mk_sec("movement"),
            mk_check("spiderman",          "m_spider",     false),
            mk_input("key",                "m_spider_key", "mouse4",true),
            mk_check("speedhack",          "m_speed_on",   false),
            mk_input("key",                "m_speed_key",  "w",true),
            mk_slider("speed",             "m_speed",      1.8,1.0,10.0),
        },
        {
            mk_sec("radar"),
            mk_check("enabled",  "r_on",      false),
            mk_slider("range",   "r_range",   200,50,1000),
            mk_check("players",  "r_players", false),
            mk_check("npc",      "r_npc",     false),
            mk_check("loot",     "r_loot",    false),
        },
        {
            mk_sec("config"),
            mk_input("menu key","cfg_menu_key","delete",true),
            mk_input("config",  "cfg_name",   "legit"),
            mk_btn("save config","cfg_save",  function() print("save") end),
            mk_btn("load config","cfg_load",  function() print("load") end),
            mk_btn("open config folder","cfg_folder",function() print("folder") end),
            mk_check("streamproof","cfg_stream",false),
            mk_sec("theme"),
            mk_combo("theme","cfg_theme",THEME_NAMES,1),
            mk_sec("ui"),
            mk_label("choose elements to display"),
            mk_multicombo("show","ui_show",{"watermark","hotkeys"},{true,true}),
        },
    },
}

local vis_categories = {
    "enemy","npc","lootable","dropped items","deployable","objectives","misc"
}
local vis_col2 = {
    enemy         = {mk_check("enabled","v_e_on",true),mk_check("sleepers","v_e_sleep",false),mk_check("downed","v_e_down",false),mk_slider("max distance","v_e_dist",500,0,2000)},
    npc           = {mk_check("enabled","v_n_on",false),mk_slider("max distance","v_n_dist",300,0,2000)},
    lootable      = {mk_check("enabled","v_l_on",false),mk_slider("max distance","v_l_dist",200,0,1000)},
    ["dropped items"] = {mk_check("enabled","v_d_on",false),mk_slider("max distance","v_d_dist",100,0,500)},
    deployable    = {mk_check("enabled","v_dp_on",false),mk_slider("max distance","v_dp_dist",150,0,500)},
    objectives    = {mk_check("enabled","v_o_on",false)},
    misc          = {mk_check("fullbright","v_m_fb",false),mk_check("no fog","v_m_fog",false)},
}
local vis_col3 = {
    enemy = {
        mk_check("box","v_e_box",true),mk_check("skeleton","v_e_skel",true),
        mk_color("box/skel color","v_e_col",{1,1,1,1}),mk_check("health bar","v_e_hp",true),
        mk_check("name","v_e_name",true),mk_color("text color","v_e_tcol",{1,1,1,1}),
        mk_check("weapon","v_e_weap",false),mk_check("distance","v_e_dist2",false),
        mk_check("flags","v_e_flags",false),mk_check("offscreen arrow","v_e_offarr",false),
        mk_color("offscreen color","v_e_offcol",{1,1,1,1}),mk_color("chams","v_e_chams",{0,0.8,1,0.5}),
    },
    npc       = {mk_check("box","v_n_box",true),mk_color("box color","v_n_col",{1,0.8,0,1}),mk_check("name","v_n_name",true)},
    lootable  = {mk_color("color","v_l_col",{0,1,0.5,1}),mk_check("name","v_l_name",true),mk_check("distance","v_l_dist2",true)},
    ["dropped items"] = {mk_color("color","v_d_col",{1,1,0,1}),mk_check("name","v_d_name",true),mk_check("distance","v_d_dist2",true)},
    deployable = {mk_color("color","v_dp_col",{0.8,0.4,1,1}),mk_check("name","v_dp_name",true)},
    objectives = {mk_color("color","v_o_col",{1,0.5,0,1}),mk_check("name","v_o_name",true)},
    misc       = {mk_check("crosshair","v_m_cross",false),mk_color("crosshair color","v_m_ccol",{1,1,1,1})},
}

local all_elements = {}
local function register_elems(list)
    if not list then return end
    for _,e in ipairs(list) do
        if e.id then all_elements[e.id] = e end
    end
end
for _,col in ipairs(tab_layouts[1]) do register_elems(col) end
for _,col in ipairs(tab_layouts[3]) do register_elems(col) end
for _,cat in pairs(vis_col2) do register_elems(cat) end
for _,cat in pairs(vis_col3) do register_elems(cat) end

local HOTKEY_DEFS = {
    {label="aimbot",     check_id="aim_on",     key_id="aim_key_lbl",  mode=2, toggle_state=false},
    {label="triggerbot", check_id="tbot_on",    key_id="tbot_key_lbl", mode=2, toggle_state=false},
    {label="spiderman",  check_id="m_spider",   key_id="m_spider_key", mode=2, toggle_state=false},
    {label="speedhack",  check_id="m_speed_on", key_id="m_speed_key",  mode=2, toggle_state=false},
}
local hk_prev_state = {}
for i=1,#HOTKEY_DEFS do hk_prev_state[i] = false end

local function hk_is_active(def, idx)
    local mode = def.mode
    if mode == 1 then
        return true
    elseif mode == 2 then
        local ke = all_elements[def.key_id]
        if not ke then return false end
        local kc = str_to_vk(ke.val)
        if not kc then return false end
        -- мышь через IsMouseButtonPressed, клавиатура через IsKeyDown
        if kc == Enum.KeyCode.LeftButton
        or kc == Enum.KeyCode.RightButton
        or kc == Enum.KeyCode.MiddleButton then
            return UserInputSvc:IsMouseButtonPressed(kc)
        end
        return UserInputSvc:IsKeyDown(kc)
    elseif mode == 3 then
        local ke = all_elements[def.key_id]
        if not ke then return def.toggle_state end
        local kc = str_to_vk(ke.val)
        if not kc then return def.toggle_state end
        local pressed
        if kc == Enum.KeyCode.LeftButton
        or kc == Enum.KeyCode.RightButton
        or kc == Enum.KeyCode.MiddleButton then
            pressed = UserInputSvc:IsMouseButtonPressed(kc)
        else
            pressed = UserInputSvc:IsKeyDown(kc)
        end
        if pressed and not hk_prev_state[idx] then
            def.toggle_state = not def.toggle_state
        end
        hk_prev_state[idx] = pressed
        return def.toggle_state
    end
    return false
end

-- ── Draw primitives ──────────────────────────────────────────
local function point_in(mx,my,x,y,w,h)
    return mx>=x and mx<=x+w and my>=y and my<=y+h
end

local function filled_rect(x,y,w,h,col,r)
    immediate.rectangle(
        Vector2.new(x,y), Vector2.new(x+w,y+h),
        r or 0, true, false, c4(col))
end
local function outline_rect(x,y,w,h,col,r)
    immediate.rectangle(
        Vector2.new(x,y), Vector2.new(x+w,y+h),
        r or 0, false, true, c4(col))
end
local function dpanel(x,y,w,h,col,bcol,r)
    filled_rect(x,y,w,h,col,r)
    if bcol then outline_rect(x,y,w,h,bcol,r) end
end
local function dtext(x,y,t,col,fd_arg)
    immediate.text(Vector2.new(x,y), t, fd_arg or FD, false, c4(col or C.text))
end
local function dcheck(x,y,val)
    filled_rect(x,y,CHK_SZ,CHK_SZ, val and C.chk_on or C.chk_off, 2)
    outline_rect(x,y,CHK_SZ,CHK_SZ, C.chk_border, 2)
    if val then
        immediate.line(Vector2.new(x+2,y+7),  Vector2.new(x+5,y+10),  1.5,false,Color4.new(1,1,1,1))
        immediate.line(Vector2.new(x+5,y+10), Vector2.new(x+11,y+3),  1.5,false,Color4.new(1,1,1,1))
    end
end
local function dswatch(x,y,w,h,col)
    filled_rect(x,y,w,h,    {0.4,0.4,0.4,1},2)
    filled_rect(x,y,w/2,h/2,{0.6,0.6,0.6,1},0)
    filled_rect(x+w/2,y+h/2,w/2,h/2,{0.6,0.6,0.6,1},0)
    filled_rect(x,y,w,h,col,2)
    outline_rect(x,y,w,h,C.chk_border,2)
end
local function dinput_box(x,y,w,val,listening)
    local bg = listening and {0.15,0.15,0.15,1} or C.input_bg
    filled_rect(x,y,w,18,bg,2)
    outline_rect(x,y,w,18,listening and C.accent or C.chk_border,2)
    local tw,th = measure(val,FD_S)
    dtext(x+4, y+9-th/2, listening and "..." or val, C.text_active, FD_S)
end
local function dbtn(x,y,w,label,mx,my)
    local hov = point_in(mx,my,x,y,w,18)
    filled_rect(x,y,w,18, hov and C.btn_hov or C.btn_bg, 2)
    outline_rect(x,y,w,18, C.chk_border, 2)
    local tw,th = measure(label,FD_S)
    dtext(x+w/2-tw/2, y+9-th/2, label, C.text_active, FD_S)
    return hov
end
local function dsection(x,y,w,label)
    filled_rect(x,y,w,SEC_H,C.section_hdr,0)
    filled_rect(x,y,2,SEC_H,C.accent,0)
    local tw,th = measure(label,FD_S)
    dtext(x+PAD_X, y+SEC_H/2-th/2, label, C.text_active, FD_S)
    return y+SEC_H
end
local function combo_preview(e)
    if e.type=="combo" then return e.items[e.val] or "?" end
    if e.type=="multicombo" then
        local sel={}
        for i,item in ipairs(e.items) do if e.val[i] then table.insert(sel,item) end end
        if #sel==0 then return "none" end
        local s=table.concat(sel,", ")
        if #s>12 then s=s:sub(1,12).."..." end
        return s
    end
    return "?"
end

-- ── Color picker ─────────────────────────────────────────────
local CP_SV=150; local CP_HW=16; local CP_AH=14; local CP_GAP=6

local function draw_colorpicker(elem,px,py,mx,my,clicked)
    local W=CP_SV+CP_GAP+CP_HW+6; local H=CP_SV+CP_GAP+CP_AH+6
    filled_rect(px-2,py-2,W+4,H+4,C.panel_dark,3)
    outline_rect(px-2,py-2,W+4,H+4,C.border_l,3)
    local sv_x=px; local sv_y=py
    local h_x=px+CP_SV+CP_GAP; local h_y=py
    local a_x=px; local a_y=py+CP_SV+CP_GAP
    local steps=20; local ss=CP_SV/steps
    for i=0,steps-1 do
        for j=0,steps-1 do
            local r,g,b=hsv_to_rgb(elem.h,(i+0.5)/steps,1-(j+0.5)/steps)
            immediate.rectangle(
                Vector2.new(sv_x+i*ss,sv_y+j*ss),
                Vector2.new(sv_x+i*ss+ss+1,sv_y+j*ss+ss+1),
                0,true,false,Color4.new(r,g,b,1))
        end
    end
    outline_rect(sv_x,sv_y,CP_SV,CP_SV,C.chk_border,0)
    local csx=sv_x+elem.s*CP_SV; local csy=sv_y+(1-elem.v)*CP_SV
    immediate.circle(Vector2.new(csx,csy),5,false,true,Color4.new(1,1,1,1))
    immediate.circle(Vector2.new(csx,csy),4,false,true,Color4.new(0,0,0,0.8))
    if clicked and point_in(mx,my,sv_x,sv_y,CP_SV,CP_SV) then cp_drag_sv=true end
    if cp_drag_sv and g_lmb then
        elem.s=math.max(0,math.min(1,(mx-sv_x)/CP_SV))
        elem.v=math.max(0,math.min(1,1-(my-sv_y)/CP_SV))
        local r,g,b=hsv_to_rgb(elem.h,elem.s,elem.v)
        elem.val[1]=r; elem.val[2]=g; elem.val[3]=b
    end
    local hs=30; local hsh=CP_SV/hs
    for i=0,hs-1 do
        local r,g,b=hsv_to_rgb(i/hs,1,1)
        immediate.rectangle(
            Vector2.new(h_x,h_y+i*hsh),
            Vector2.new(h_x+CP_HW,h_y+i*hsh+hsh+1),
            0,true,false,Color4.new(r,g,b,1))
    end
    outline_rect(h_x,h_y,CP_HW,CP_SV,C.chk_border,0)
    filled_rect(h_x-2,h_y+elem.h*CP_SV-1,CP_HW+4,3,{1,1,1,1},0)
    if clicked and point_in(mx,my,h_x,h_y,CP_HW,CP_SV) then cp_drag_h=true end
    if cp_drag_h and g_lmb then
        elem.h=math.max(0,math.min(1,(my-h_y)/CP_SV))
        local r,g,b=hsv_to_rgb(elem.h,elem.s,elem.v)
        elem.val[1]=r; elem.val[2]=g; elem.val[3]=b
    end
    local aw=CP_SV+CP_GAP+CP_HW; local csz=7
    for ci=0,math.floor(aw/csz) do
        local cc=(ci%2==0) and {0.6,0.6,0.6,1} or {0.4,0.4,0.4,1}
        filled_rect(a_x+ci*csz,a_y,csz,CP_AH,cc,0)
    end
    local ast=20; local asw=aw/ast
    for i=0,ast-1 do
        immediate.rectangle(
            Vector2.new(a_x+i*asw,a_y),
            Vector2.new(a_x+i*asw+asw+1,a_y+CP_AH),
            0,true,false,
            Color4.new(elem.val[1],elem.val[2],elem.val[3],i/(ast-1)))
    end
    outline_rect(a_x,a_y,aw,CP_AH,C.chk_border,0)
    filled_rect(a_x+elem.val[4]*aw-1,a_y-2,3,CP_AH+4,{1,1,1,1},0)
    if clicked and point_in(mx,my,a_x,a_y,aw,CP_AH) then cp_drag_a=true end
    if cp_drag_a and g_lmb then
        elem.val[4]=math.max(0,math.min(1,(mx-a_x)/aw))
    end
    if not g_lmb then cp_drag_sv=false; cp_drag_h=false; cp_drag_a=false end
end

-- ── Dropdown ─────────────────────────────────────────────────
local function draw_dropdown(e,dd_x,dd_y,dd_w,mx,my,clicked)
    local count=#e.items; local dd_h=count*DD_ROW+4
    filled_rect(dd_x,dd_y,dd_w,dd_h,C.dropdown_bg,2)
    outline_rect(dd_x,dd_y,dd_w,dd_h,C.border_l,2)
    for i,item in ipairs(e.items) do
        local iy=dd_y+2+(i-1)*DD_ROW
        local hov=point_in(mx,my,dd_x,iy,dd_w,DD_ROW)
        local is_sel=(e.type=="combo") and (e.val==i) or (e.type=="multicombo" and e.val[i])
        if hov then filled_rect(dd_x+1,iy,dd_w-2,DD_ROW,C.dropdown_hov,2) end
        if is_sel then filled_rect(dd_x+1,iy,2,DD_ROW,C.accent,0) end
        if e.type=="multicombo" then dcheck(dd_x+dd_w-PAD_X-CHK_SZ,iy+DD_ROW/2-CHK_SZ/2,e.val[i]) end
        local lw,lh=measure(item,FD_S)
        dtext(dd_x+PAD_X+4,iy+DD_ROW/2-lh/2,item,is_sel and C.text_active or C.text,FD_S)
        if clicked and hov then
            if e.type=="combo" then
                e.val=i; dd_open_id=nil
                if e.id=="cfg_theme" then apply_theme(THEME_NAMES[i]) end
            elseif e.type=="multicombo" then e.val[i]=not e.val[i] end
        end
    end
    if clicked and not point_in(mx,my,dd_x,dd_y,dd_w,dd_h) then dd_open_id=nil end
end

-- ── Context menu ─────────────────────────────────────────────
local function draw_context_menu(mx,my,lmb_clicked)
    if not ctx_open then return end
    local max_w=0
    for _,m in ipairs(CTX_MODES) do local mw,_=measure(m,FD_S); if mw>max_w then max_w=mw end end
    local ctx_w=max_w+CTX_PAD_X*2; local ctx_h=#CTX_MODES*CTX_ROW_H+CTX_PAD_Y*2
    filled_rect(ctx_x,ctx_y,ctx_w,ctx_h,C.ctx_bg,3)
    outline_rect(ctx_x,ctx_y,ctx_w,ctx_h,C.ctx_border,3)
    local def=HOTKEY_DEFS[ctx_hk_idx]
    for i,mode_name in ipairs(CTX_MODES) do
        local iy=ctx_y+CTX_PAD_Y+(i-1)*CTX_ROW_H
        local hov=point_in(mx,my,ctx_x,iy,ctx_w,CTX_ROW_H)
        local is_cur=def and (def.mode==i)
        if hov then filled_rect(ctx_x+1,iy,ctx_w-2,CTX_ROW_H,C.ctx_hov,2) end
        if is_cur then filled_rect(ctx_x+1,iy,2,CTX_ROW_H,C.accent,0) end
        local lw,lh=measure(mode_name,FD_S)
        dtext(ctx_x+CTX_PAD_X,iy+CTX_ROW_H/2-lh/2,mode_name,is_cur and C.ctx_active or C.ctx_text,FD_S)
        if lmb_clicked and hov then
            if def then def.mode=i; def.toggle_state=false; hk_prev_state[ctx_hk_idx]=false end
            ctx_open=false
        end
    end
    if lmb_clicked and not point_in(mx,my,ctx_x,ctx_y,ctx_w,ctx_h) then ctx_open=false end
end

-- ── Column renderer ──────────────────────────────────────────
local function draw_column(elems,col_x,start_y,col_w,mx,my,clicked)
    local cy=start_y
    for _,e in ipairs(elems) do
        if e.type=="section" then
            cy=dsection(col_x,cy,col_w,e.label)+2
        elseif e.type=="check" then
            local lw,lh=measure(e.label,FD)
            dtext(col_x+PAD_X,cy+ROW_H/2-lh/2,e.label,C.text,FD)
            local cx2=col_x+col_w-PAD_X-CHK_SZ; local cy2=cy+ROW_H/2-CHK_SZ/2
            dcheck(cx2,cy2,e.val)
            if clicked and point_in(mx,my,col_x+PAD_X,cy,col_w-PAD_X*2,ROW_H) then
                e.val=not e.val
                if cp_open and cp_elem_id~=e.id then cp_open=false end
                if dd_open_id~=e.id then dd_open_id=nil end
            end
            cy=cy+ROW_H
        elseif e.type=="slider" then
            cy=cy+2
            local vs=e.val~=math.floor(e.val)
                and e.label.." - "..string.format("%.1f",e.val)
                or  e.label.." - "..tostring(math.floor(e.val))
            local lw,lh=measure(vs,FD_S)
            dtext(col_x+PAD_X,cy,vs,C.text,FD_S)
            cy=cy+lh+3
            local sl_x=col_x+PAD_X; local sl_w=col_w-PAD_X*2; local sh=8
            local ratio=math.max(0,math.min(1,(e.val-e.min)/(e.max-e.min)))
            local fill=math.floor(sl_w*ratio)
            filled_rect(sl_x,cy,sl_w,sh,C.slider_bg,3)
            if fill>0 then filled_rect(sl_x,cy,fill,sh,C.slider_fill,3) end
            outline_rect(sl_x,cy,sl_w,sh,C.chk_border,3)
            if clicked and point_in(mx,my,sl_x,cy,sl_w,sh) then drag_slider_id=e.id end
            if drag_slider_id==e.id and g_lmb then
                e.val=e.min+math.max(0,math.min(1,(mx-sl_x)/sl_w))*(e.max-e.min)
            end
            cy=cy+sh+PAD_Y
        elseif e.type=="color" then
            local lw,lh=measure(e.label,FD)
            dtext(col_x+PAD_X,cy+ROW_H/2-lh/2,e.label,C.text,FD)
            local sw=60; local sx2=col_x+col_w-PAD_X-sw; local sy2=cy+ROW_H/2-8
            dswatch(sx2,sy2,sw,16,e.val)
            if clicked and point_in(mx,my,sx2,sy2,sw,16) then
                if cp_open and cp_elem_id==e.id then cp_open=false; cp_elem_id=nil
                else cp_open=true; cp_elem_id=e.id; dd_open_id=nil end
            end
            if cp_open and cp_elem_id==e.id then
                local cpx=sx2-CP_SV-CP_GAP-CP_HW-10; local cpy=cy
                cpx=math.max(WIN_X+2,math.min(cpx,WIN_X+WIN_W-(CP_SV+CP_GAP+CP_HW+10)))
                cpy=math.max(WIN_Y+HDR_H+2,cpy)
                table.insert(pending_colorpickers,{elem=e,px=cpx,py=cpy})
            end
            cy=cy+ROW_H
        elseif e.type=="input" then
            local lw,lh=measure(e.label,FD)
            dtext(col_x+PAD_X,cy+ROW_H/2-lh/2,e.label,C.text,FD)
            local iw=80; local ix=col_x+col_w-PAD_X-iw; local iy2=cy+ROW_H/2-9
            local is_list=kb_listening_id==e.id
            dinput_box(ix,iy2,iw,e.val,is_list)
            if clicked and point_in(mx,my,ix,iy2,iw,18) then
                if e.is_keybind then kb_listening_id=is_list and nil or e.id end
            end
            cy=cy+ROW_H
        elseif e.type=="button" then
            local bw=col_w-PAD_X*2
            local hov=dbtn(col_x+PAD_X,cy+2,bw,e.label,mx,my)
            if clicked and hov and e.cb then e.cb() end
            cy=cy+24
        elseif e.type=="label" then
            local lw,lh=measure(e.label,FD_S)
            dtext(col_x+PAD_X,cy+4,e.label,C.text_dim,FD_S)
            cy=cy+lh+8
        elseif e.type=="combo" or e.type=="multicombo" then
            local lw,lh=measure(e.label,FD)
            dtext(col_x+PAD_X,cy+ROW_H/2-lh/2,e.label,C.text,FD)
            local box_w=80; local box_x=col_x+col_w-PAD_X-box_w; local box_y=cy+ROW_H/2-9
            local is_open=dd_open_id==e.id
            filled_rect(box_x,box_y,box_w,18,is_open and C.btn_hov or C.input_bg,2)
            outline_rect(box_x,box_y,box_w,18,is_open and C.accent or C.chk_border,2)
            local preview=combo_preview(e)
            local pw,ph=measure(preview,FD_S)
            dtext(box_x+4,box_y+9-ph/2,preview,C.text_active,FD_S)
            local arr=is_open and "^" or "v"
            local aw2,ah=measure(arr,FD_S)
            dtext(box_x+box_w-aw2-4,box_y+9-ah/2,arr,C.text_dim,FD_S)
            if clicked and point_in(mx,my,box_x,box_y,box_w,18) then
                dd_open_id=is_open and nil or e.id; cp_open=false
            end
            if is_open then
                table.insert(pending_dropdowns,{elem=e,dd_x=box_x,dd_y=box_y+20,dd_w=box_w})
            end
            cy=cy+ROW_H
        end
    end
end

-- ── Watermark ────────────────────────────────────────────────
local function draw_watermark(mx,my,clicked)
    local ui_show=all_elements["ui_show"]
    if ui_show and not ui_show.val[1] then return end
    local text="nyanwolf.net"
    local tw,th=measure(text,FD_S); local w=tw+PAD_X*2; local h=th+PAD_Y*2
    if clicked and point_in(mx,my,wm_x,wm_y,w,h) then
        wm_dragging=true; wm_drag_ox=mx-wm_x; wm_drag_oy=my-wm_y
    end
    if not g_lmb then wm_dragging=false end
    if wm_dragging then wm_x=mx-wm_drag_ox; wm_y=my-wm_drag_oy end
    filled_rect(wm_x,wm_y,w,h,C.wm_bg,3)
    outline_rect(wm_x,wm_y,w,h,C.wm_border,3)
    filled_rect(wm_x,wm_y,2,h,C.accent,0)
    dtext(wm_x+PAD_X,wm_y+PAD_Y,text,C.wm_text,FD_S)
end

-- ── Hotkeys panel ────────────────────────────────────────────
local function draw_hotkeys(mx,my,lmb_clicked,rmb_clicked)
    local ui_show=all_elements["ui_show"]
    if ui_show and not ui_show.val[2] then return end
    if #HOTKEY_DEFS==0 then return end
    local row_h=FONT_SIZE_S+10; local title="hotkeys"
    local tw,th=measure(title,FD_S); local content_w=tw
    for _,def in ipairs(HOTKEY_DEFS) do
        local ke=all_elements[def.key_id]; local key_str=ke and ke.val or "?"
        local line=def.label.." - "..key_str.."  ["..CTX_MODES[def.mode].."]"
        local lw,_=measure(line,FD_S); if lw+16>content_w then content_w=lw+16 end
    end
    local box_w=content_w+PAD_X*2; local hdr_h=th+PAD_Y*2
    local box_h=hdr_h+#HOTKEY_DEFS*row_h+PAD_Y
    if hk_x==nil then hk_x=1280-box_w-10; hk_y=720-box_h-10 end
    if lmb_clicked and point_in(mx,my,hk_x,hk_y,box_w,box_h) then
        hk_dragging=true; hk_drag_ox=mx-hk_x; hk_drag_oy=my-hk_y
    end
    if not g_lmb then hk_dragging=false end
    if hk_dragging then hk_x=mx-hk_drag_ox; hk_y=my-hk_drag_oy end
    filled_rect(hk_x,hk_y,box_w,box_h,C.hk_bg,3)
    outline_rect(hk_x,hk_y,box_w,box_h,C.hk_border,3)
    filled_rect(hk_x,hk_y,box_w,hdr_h,C.hk_header,0)
    filled_rect(hk_x,hk_y,2,hdr_h,C.accent,0)
    local tlw,tlh=measure(title,FD_S)
    dtext(hk_x+box_w/2-tlw/2,hk_y+PAD_Y,title,C.hk_title,FD_S)
    filled_rect(hk_x,hk_y+hdr_h,box_w,1,C.hk_border,0)
    for i,def in ipairs(HOTKEY_DEFS) do
        local ry=hk_y+hdr_h+(i-1)*row_h+PAD_Y/2+2
        local active=hk_is_active(def,i)
        local text_col=active and C.hk_title or C.text_dim
        local dot_col=active and {0.20,0.85,0.35,1.0} or {0.22,0.22,0.22,1.0}
        local dot_r=3; local dot_cx=hk_x+PAD_X+dot_r; local dot_cy=ry+FONT_SIZE_S/2+1
        if active then
            immediate.circle(Vector2.new(dot_cx,dot_cy),dot_r+3,true,false,Color4.new(dot_col[1],dot_col[2],dot_col[3],0.15))
            immediate.circle(Vector2.new(dot_cx,dot_cy),dot_r+1,true,false,Color4.new(dot_col[1],dot_col[2],dot_col[3],0.30))
        end
        immediate.circle(Vector2.new(dot_cx,dot_cy),dot_r,true,false,Color4.new(dot_col[1],dot_col[2],dot_col[3],1))
        immediate.circle(Vector2.new(dot_cx,dot_cy),dot_r,false,true,Color4.new(dot_col[1]*0.6,dot_col[2]*0.6,dot_col[3]*0.6,1))
        local ke=all_elements[def.key_id]; local key_str=ke and ke.val or "?"
        dtext(hk_x+PAD_X+dot_r*2+5,ry,def.label.." - "..key_str,text_col,FD_S)
        local mode_str="["..CTX_MODES[def.mode].."]"; local mw,mh=measure(mode_str,FD_S)
        local mc={math.min(1,C.text_dim[1]*1.4),math.min(1,C.text_dim[2]*1.4),math.min(1,C.text_dim[3]*1.4),1}
        dtext(hk_x+box_w-PAD_X-mw,ry+FONT_SIZE_S/2-mh/2+1,mode_str,mc,FD_S)
        if rmb_clicked and point_in(mx,my,hk_x,ry,box_w,row_h) then
            ctx_open=true; ctx_hk_idx=i; ctx_x=mx; ctx_y=my
        end
        if i<#HOTKEY_DEFS then
            filled_rect(hk_x+PAD_X,ry+row_h-1,box_w-PAD_X*2,1,
                {C.hk_border[1],C.hk_border[2],C.hk_border[3],0.35},0)
        end
    end
end

-- ── Heartbeat: обновляем состояние ввода ─────────────────────
RunService.Heartbeat:Connect(function()
    -- ── Позиция мыши через UserInputService ──────────────────
    local ml = UserInputSvc:GetMouseLocation()
    g_mx = ml.X
    g_my = ml.Y

    -- ── Кнопки мыши через IsMouseButtonPressed ───────────────
    g_lmb_prev = g_lmb
    g_rmb_prev = g_rmb
    g_lmb = UserInputSvc:IsMouseButtonPressed(Enum.KeyCode.LeftButton)
    g_rmb = UserInputSvc:IsMouseButtonPressed(Enum.KeyCode.RightButton)

    -- ── Клавиша меню ─────────────────────────────────────────
    local cfg_key_elem = all_elements["cfg_menu_key"]
    if cfg_key_elem then
        local parsed = str_to_vk(cfg_key_elem.val)
        if parsed then menu_bind_vk = parsed end
    end

    local bind_now
    if menu_bind_vk == Enum.KeyCode.LeftButton
    or menu_bind_vk == Enum.KeyCode.RightButton
    or menu_bind_vk == Enum.KeyCode.MiddleButton then
        bind_now = UserInputSvc:IsMouseButtonPressed(menu_bind_vk)
    else
        bind_now = UserInputSvc:IsKeyDown(menu_bind_vk)
    end

    if bind_now and not menu_bind_was then
        menu_open = not menu_open
        if not menu_open then
            cp_open=false; kb_listening_id=nil; dd_open_id=nil; ctx_open=false
        end
    end
    menu_bind_was = bind_now

    -- ── Keybind listening ─────────────────────────────────────
    if kb_listening_id then
        -- сначала проверяем кнопки мыши
        local mouse_btns = {
            Enum.KeyCode.LeftButton,
            Enum.KeyCode.RightButton,
            Enum.KeyCode.MiddleButton,
        }
        local caught = false
        for _,btn in ipairs(mouse_btns) do
            if UserInputSvc:IsMouseButtonPressed(btn) then
                local e = all_elements[kb_listening_id]
                if e then
                    e.val = vk_to_str(btn)
                    if kb_listening_id == "cfg_menu_key" then
                        menu_bind_vk = btn
                    end
                end
                kb_listening_id = nil
                caught = true
                break
            end
        end
        -- потом клавиатуру
        if not caught then
            for _,kc in ipairs(ALL_KEYCODES) do
                if kc ~= Enum.KeyCode.LeftButton
                and kc ~= Enum.KeyCode.RightButton
                and kc ~= Enum.KeyCode.MiddleButton
                and UserInputSvc:IsKeyDown(kc) then
                    local e = all_elements[kb_listening_id]
                    if e then
                        e.val = vk_to_str(kc)
                        if kb_listening_id == "cfg_menu_key" then
                            local p = str_to_vk(e.val)
                            if p then menu_bind_vk = p end
                        end
                    end
                    kb_listening_id = nil
                    break
                end
            end
        end
    end

    if not g_lmb then drag_slider_id = nil end
end)

-- ── PreRender: только рисование ──────────────────────────────
RunService.PreRender:Connect(function()
    local mx = g_mx
    local my = g_my

    local lmb_clicked = g_lmb and not g_lmb_prev
    local rmb_clicked = g_rmb and not g_rmb_prev

    local menu_captured = menu_open and point_in(mx,my,WIN_X,WIN_Y,WIN_W,WIN_H)
    local overlay_lmb   = lmb_clicked and not menu_captured
    local overlay_rmb   = rmb_clicked and not menu_captured

    draw_watermark(mx,my,overlay_lmb)
    draw_hotkeys(mx,my,overlay_lmb,overlay_rmb)
    draw_context_menu(mx,my,lmb_clicked)

    if not menu_open then return end

    if lmb_clicked and not point_in(mx,my,WIN_X,WIN_Y,WIN_W,WIN_H) then
        cp_open=false; cp_elem_id=nil; dd_open_id=nil; kb_listening_id=nil
    end

    if lmb_clicked and point_in(mx,my,WIN_X,WIN_Y,WIN_W,HDR_H) then
        dragging=true; drag_ox=mx-WIN_X; drag_oy=my-WIN_Y
    end
    if not g_lmb then dragging=false end
    if dragging then WIN_X=mx-drag_ox; WIN_Y=my-drag_oy end

    local content_y = WIN_Y+HDR_H
    local tab_y     = WIN_Y+WIN_H-TAB_H
    local content_h = WIN_H-HDR_H-TAB_H

    pending_colorpickers = {}
    pending_dropdowns    = {}

    filled_rect(WIN_X,WIN_Y,WIN_W,WIN_H,C.bg,2)
    outline_rect(WIN_X,WIN_Y,WIN_W,WIN_H,C.border_l,2)

    filled_rect(WIN_X,WIN_Y,WIN_W,HDR_H,C.header,2)
    filled_rect(WIN_X,WIN_Y+HDR_H-1,WIN_W,1,C.border_l,0)
    local bind_str=vk_to_str(menu_bind_vk)
    local htitle="nyanwolf.net  |  "..tabs[active_tab].."  |  ["..bind_str.."]"
    local htw,hth=measure(htitle,FD_S)
    dtext(WIN_X+WIN_W/2-htw/2,WIN_Y+HDR_H/2-hth/2,htitle,C.title_text,FD_S)

    local tab_w=WIN_W/#tabs
    for i,tname in ipairs(tabs) do
        local tx=WIN_X+(i-1)*tab_w
        filled_rect(tx,tab_y,tab_w,TAB_H,i==active_tab and C.tab_active or C.tab_idle,0)
        if i==active_tab then filled_rect(tx,tab_y+TAB_H-2,tab_w,2,C.accent,0) end
        if i>1 then filled_rect(tx,tab_y+4,1,TAB_H-8,C.separator,0) end
        local lw2,lh2=measure(tname,FD)
        dtext(tx+tab_w/2-lw2/2,tab_y+TAB_H/2-lh2/2,tname,
            i==active_tab and C.text_active or C.text_dim,FD)
        if lmb_clicked and point_in(mx,my,tx,tab_y,tab_w,TAB_H) then
            active_tab=i; active_sel=1; cp_open=false; cp_elem_id=nil; dd_open_id=nil
        end
    end

    if active_tab==2 then
        local col_w=math.floor(WIN_W/3)
        local x1=WIN_X; local x2=WIN_X+col_w; local x3=WIN_X+col_w*2
        filled_rect(x1,content_y,col_w,content_h,C.panel_dark,0)
        filled_rect(x1+col_w-1,content_y,1,content_h,C.border_l,0)
        filled_rect(x1,content_y,col_w,SEC_H+4,C.section_hdr,0)
        filled_rect(x1,content_y,2,SEC_H+4,C.accent,0)
        local stw,sth=measure("selection",FD_S)
        dtext(x1+PAD_X,content_y+SEC_H/2+2-sth/2,"selection",C.text_dim,FD_S)
        filled_rect(x1,content_y+SEC_H+4,col_w,1,C.separator,0)
        local sel_y=content_y+SEC_H+8
        for i,cat in ipairs(vis_categories) do
            local ry=sel_y+(i-1)*ROW_H; local is_act=i==active_sel
            if is_act then
                filled_rect(x1+2,ry,col_w-3,ROW_H-1,C.sel_active,2)
                filled_rect(x1+2,ry,2,ROW_H-1,C.accent,0)
            elseif point_in(mx,my,x1,ry,col_w,ROW_H) then
                filled_rect(x1+2,ry,col_w-3,ROW_H-1,C.sel_hover,2)
            end
            local lw2,lh2=measure(cat,FD)
            dtext(x1+PAD_X+6,ry+ROW_H/2-lh2/2,cat,is_act and C.text_active or C.text,FD)
            if lmb_clicked and point_in(mx,my,x1,ry,col_w,ROW_H) then
                active_sel=i; cp_open=false; dd_open_id=nil
            end
        end
        local cur=vis_categories[active_sel]
        filled_rect(x2,content_y,col_w,content_h,C.panel,0)
        filled_rect(x2+col_w-1,content_y,1,content_h,C.border_l,0)
        local c2h="filters  ("..cur..")"; local c2hw,c2hh=measure(c2h,FD_S)
        filled_rect(x2,content_y,col_w,SEC_H+4,C.section_hdr,0)
        filled_rect(x2,content_y,2,SEC_H+4,C.accent,0)
        dtext(x2+PAD_X,content_y+SEC_H/2+2-c2hh/2,c2h,C.text_dim,FD_S)
        filled_rect(x2,content_y+SEC_H+4,col_w,1,C.separator,0)
        draw_column(vis_col2[cur] or {},x2,content_y+SEC_H+8,col_w,mx,my,lmb_clicked)
        filled_rect(x3,content_y,col_w,content_h,C.panel,0)
        local c3h="options  ("..cur..")"; local c3hw,c3hh=measure(c3h,FD_S)
        filled_rect(x3,content_y,col_w,SEC_H+4,C.section_hdr,0)
        filled_rect(x3,content_y,2,SEC_H+4,C.accent,0)
        dtext(x3+PAD_X,content_y+SEC_H/2+2-c3hh/2,c3h,C.text_dim,FD_S)
        filled_rect(x3,content_y+SEC_H+4,col_w,1,C.separator,0)
        draw_column(vis_col3[cur] or {},x3,content_y+SEC_H+8,col_w,mx,my,lmb_clicked)
    else
        local layout=tab_layouts[active_tab]; local ncols=#layout
        if ncols>0 then
            local col_w=WIN_W/ncols
            for ci,col_elems in ipairs(layout) do
                local cx2=WIN_X+(ci-1)*col_w
                filled_rect(cx2,content_y,col_w,content_h,C.panel_dark,0)
                if ci<ncols then filled_rect(cx2+col_w-1,content_y,1,content_h,C.separator,0) end
                if col_elems then draw_column(col_elems,cx2,content_y+2,col_w,mx,my,lmb_clicked) end
            end
        end
    end

    outline_rect(WIN_X,WIN_Y,WIN_W,WIN_H,C.border_l,2)

    for _,cp in ipairs(pending_colorpickers) do
        draw_colorpicker(cp.elem,cp.px,cp.py,mx,my,lmb_clicked)
    end
    for _,dd in ipairs(pending_dropdowns) do
        draw_dropdown(dd.elem,dd.dd_x,dd.dd_y,dd.dd_w,mx,my,lmb_clicked)
    end
end)

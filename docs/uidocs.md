# cathook ui documentation (i guess it will work but in some way no, bc all of that documentation are vibecoded, sowwy ＞﹏＜

## Quick Start

The GUI is built from **elements** grouped into **columns**, columns grouped into **tabs**. Everything is registered automatically in `all_elements` when an `id` is provided.

---

## Elements

### Checkbox
```lua
mk_check(label, id, default)
```
```lua
mk_check("enabled", "my_feature", false)
```
Read value:
```lua
local enabled = all_elements["my_feature"].val  -- boolean
```

---

### Slider
```lua
mk_slider(label, id, default, min, max)
```
```lua
mk_slider("speed", "my_speed", 1.0, 0.1, 10.0)
mk_slider("fov",   "my_fov",   90,  10,  300)
```
Read value:
```lua
local speed = all_elements["my_speed"].val  -- number
```
If the value is an integer it displays as `speed - 5`, if float as `speed - 1.5`.

---

### Combo
```lua
mk_combo(label, id, items_table, default_index)
```
```lua
mk_combo("mode", "my_mode", {"Camera", "Silent", "Lerp"}, 1)
```
Read value:
```lua
local idx  = all_elements["my_mode"].val         -- number (1-based)
local name = all_elements["my_mode"].items[idx]   -- string
```

---

### Multicombo
```lua
mk_multicombo(label, id, items_table, defaults_table)
```
```lua
mk_multicombo("hitboxes", "my_hbox",
    {"Head", "Torso", "Arms", "Legs"},
    {true, true, false, false})
```
Read value:
```lua
local hbox = all_elements["my_hbox"].val
if hbox[1] then print("Head enabled") end
if hbox[2] then print("Torso enabled") end
```

---

### Color picker
```lua
mk_color(label, id, {r, g, b, a})
```
```lua
mk_color("box color", "my_color", {1, 0.5, 0, 1})
```
Read value:
```lua
local col = all_elements["my_color"].val  -- {r, g, b, a} all 0.0–1.0
draw.box(x, y, w, h, col)
```

---

### Input / Keybind
```lua
mk_input(label, id, default, is_keybind)
```
```lua
-- plain text input
mk_input("config name", "cfg_name", "legit")

-- keybind (opens listener on click)
mk_input("key", "my_key", "f", true)
```
Read keybind:
```lua
local key_str = all_elements["my_key"].val   -- e.g. "f", "mouse2", "insert"
local vk      = str_to_vk(key_str)           -- VK code for input.is_key_down()
if vk and input.is_key_down(vk) then
    -- key is held
end
```

---

### Button
```lua
mk_btn(label, id, callback)
```
```lua
mk_btn("reset", "my_btn", function()
    all_elements["my_speed"].val = 1.0
    print("reset")
end)
```

---

### Label
```lua
mk_label(text)
```
```lua
mk_label("this is just a hint text")
```
No `id`, purely visual.

---

### Section header
```lua
mk_sec(label)
```
```lua
mk_sec("movement settings")
```
Renders a dark bar with text and an accent stripe on the left. Visually separates elements.

---

## Columns and Tabs

### Tab structure
Each tab is a table of **columns**. Each column is a table of elements. Columns share the window width equally.

```lua
tab_layouts[1] = {
    -- column 1
    {
        mk_sec("aimbot"),
        mk_check("enabled", "aim_on", false),
        mk_slider("fov", "aim_fov", 90, 10, 300),
    },
    -- column 2
    {
        mk_sec("settings"),
        mk_combo("mode", "aim_mode", {"Head", "Body"}, 1),
        mk_color("color", "aim_col", {1, 0, 0, 1}),
    },
}
```

### Adding a new tab
```lua
-- 1. Add name to the tabs list
local tabs = {"aimbot", "visuals", "misc", "myfeature"}

-- 2. Add layout
tab_layouts[4] = {
    {
        mk_sec("my section"),
        mk_check("something", "my_something", false),
    },
}

-- 3. Register elements
for _, col in ipairs(tab_layouts[4]) do register_elems(col) end
```

---

## Hotkey List

The hotkey list is always rendered on top of the game. Each row shows:
- **dot** — green if active, grey if not
- **label - key** — feature name and bound key
- **[Mode]** — current mode on the right
- **RMB** on any row — opens mode selector

### Add a feature to the hotkey list
```lua
-- inside HOTKEY_DEFS table:
{label="myfeature", check_id="my_on", key_id="my_key", mode=2, toggle_state=false},
```
`hk_prev_state` is initialized automatically in a loop over `HOTKEY_DEFS`, so just add the entry before that loop runs.

### Modes
| Mode | Behaviour | Dot |
|---|---|---|
| `Always` (1) | Always green, no conditions | 🟢 always |
| `Hold` (2) | Green while the key is physically held | 🟢 while held |
| `Toggle` (3) | Switches on each key press | 🟢 / ⚫ |

---

## Themes

### Theme structure
```lua
THEMES["MyTheme"] = {
    -- backgrounds
    bg          = {r, g, b, a},  -- main window background
    panel       = {r, g, b, a},  -- column background
    panel_dark  = {r, g, b, a},  -- dark column background
    header      = {r, g, b, a},  -- header background

    -- tabs
    tab_active  = {r, g, b, a},
    tab_idle    = {r, g, b, a},

    -- visuals selection list
    sel_active  = {r, g, b, a},
    sel_hover   = {r, g, b, a},

    -- section header bar
    section_hdr = {r, g, b, a},

    -- borders
    border_l    = {r, g, b, a},
    border_r    = {r, g, b, a},

    -- accent (stripes, active elements)
    accent      = {r, g, b, a},

    -- text
    text        = {r, g, b, a},  -- normal
    text_dim    = {r, g, b, a},  -- muted
    text_active = {r, g, b, a},  -- active / bright

    -- checkbox
    chk_on      = {r, g, b, a},
    chk_off     = {r, g, b, a},
    chk_border  = {r, g, b, a},

    -- slider
    slider_bg   = {r, g, b, a},
    slider_fill = {r, g, b, a},

    -- buttons
    btn_bg      = {r, g, b, a},
    btn_hov     = {r, g, b, a},

    -- input / dropdown
    input_bg    = {r, g, b, a},
    dropdown_bg = {r, g, b, a},
    dropdown_hov= {r, g, b, a},

    -- misc
    separator   = {r, g, b, a},
    title_text  = {r, g, b, a},

    -- watermark
    wm_bg       = {r, g, b, a},
    wm_border   = {r, g, b, a},
    wm_text     = {r, g, b, a},

    -- hotkey list
    hk_bg       = {r, g, b, a},
    hk_border   = {r, g, b, a},
    hk_header   = {r, g, b, a},
    hk_text     = {r, g, b, a},
    hk_title    = {r, g, b, a},

    -- context menu
    ctx_bg      = {r, g, b, a},
    ctx_border  = {r, g, b, a},
    ctx_hov     = {r, g, b, a},
    ctx_text    = {r, g, b, a},
    ctx_active  = {r, g, b, a},
}
```

### Register the theme
```lua
-- add to THEME_NAMES:
local THEME_NAMES = {"Dark", "Forest", "Ocean", "Crimson", "Midnight", "MyTheme"}

-- the combo in misc picks it up automatically
```

---

## Visuals Tab (tab 2)

The visuals tab has three fixed equal-width columns:
- **selection** — category list
- **filters** — visibility settings for the selected category
- **options** — visual settings for the selected category

### Add a category
```lua
-- 1. Add to the category list
local vis_categories = {
    "enemy", "npc", "lootable", "mycategory"
}

-- 2. filters column
vis_col2["mycategory"] = {
    mk_check("enabled",      "v_my_on",   false),
    mk_slider("max distance","v_my_dist", 300, 0, 2000),
}

-- 3. options column
vis_col3["mycategory"] = {
    mk_check("box",   "v_my_box", true),
    mk_color("color", "v_my_col", {1, 0.5, 0, 1}),
    mk_check("name",  "v_my_name",true),
}

-- 4. Register
register_elems(vis_col2["mycategory"])
register_elems(vis_col3["mycategory"])
```

---

## Watermark and Hotkey List

Both elements:
- Are rendered **always**, even when the menu is closed
- Can be **dragged** by holding LMB
- Can be **hidden** via misc → ui → show (multicombo)

### Default positions
```lua
-- watermark: top-left corner
local wm_x = 10
local wm_y = 10

-- hotkey list: bottom-right corner (computed on first render)
local hk_x = nil
local hk_y = nil
```

### Override position in code
```lua
wm_x = 500
wm_y = 20

hk_x = 100
hk_y = 100
```

---

## Menu Keybind

Default is `Insert`. Change it via **misc → config → menu key** — click the field and press any key. The current bind is shown in the header inside `[brackets]`.

Supported key names: `mouse1–5`, `f1–f12`, `a–z`, `0–9`, `shift`, `ctrl`, `alt`, `space`, `enter`, `esc`, `insert`, `delete`, `back`, `tab`.

---

## Reading Values in on_frame

```lua
function on_frame()
    -- checkbox
    local enabled = all_elements["aim_on"].val        -- boolean

    -- slider
    local fov = all_elements["aim_fov"].val           -- number

    -- combo
    local idx  = all_elements["aim_mode"].val         -- number (1-based)
    local name = all_elements["aim_mode"].items[idx]  -- string

    -- multicombo
    local hbox    = all_elements["aim_hbox"].val
    local head_on = hbox[1]                           -- boolean

    -- color
    local col = all_elements["my_color"].val          -- {r, g, b, a}

    -- keybind
    local key_str = all_elements["my_key"].val        -- string e.g. "f"
    local vk      = str_to_vk(key_str)
    local held    = vk and input.is_key_down(vk)      -- boolean
end
```

---

## Full Feature Example

Adding a **noclip** feature with a keybind and settings.

### 1. Elements in misc column 1
```lua
mk_sec("noclip"),
mk_check("enabled",   "nc_on",    false),
mk_input("key",       "nc_key",   "v", true),
mk_slider("speed",    "nc_speed", 2.0, 0.5, 10.0),
mk_color("color",     "nc_col",   {0, 1, 0.5, 0.8}),
```

### 2. Add to hotkey list
```lua
local HOTKEY_DEFS = {
    -- ... existing entries ...
    {label="noclip", check_id="nc_on", key_id="nc_key", mode=2, toggle_state=false},
}
```

### 3. Logic in on_frame
```lua
function on_frame()
    local nc_on  = all_elements["nc_on"]
    local nc_key = all_elements["nc_key"]
    if not nc_on or not nc_key then return end

    local vk     = str_to_vk(nc_key.val)
    local active = nc_on.val and vk and input.is_key_down(vk)

    if active then
        local char = game.local_player.character
        if char then
            for _, part in ipairs(char:get_children()) do
                if part:is_a("BasePart") then
                    part.can_collide = false
                end
            end
        end
    end
end
```

---

## Element Reference

| Function | Parameters | Description |
|---|---|---|
| `mk_check` | `label, id, bool` | Checkbox |
| `mk_slider` | `label, id, val, min, max` | Slider |
| `mk_combo` | `label, id, items, idx` | Dropdown |
| `mk_multicombo` | `label, id, items, defaults` | Multi-select dropdown |
| `mk_color` | `label, id, {r,g,b,a}` | Color picker |
| `mk_input` | `label, id, val, is_keybind` | Text field or keybind |
| `mk_btn` | `label, id, callback` | Button |
| `mk_label` | `text` | Static label (no id) |
| `mk_sec` | `label` | Section header (no id) |

## Value Types Reference

| Element type | `.val` type | Example |
|---|---|---|
| `check` | `boolean` | `true` |
| `slider` | `number` | `1.8` |
| `combo` | `number` (1-based index) | `2` |
| `multicombo` | `table of boolean` | `{true, false, true}` |
| `color` | `table {r, g, b, a}` | `{1, 0.5, 0, 1}` |
| `input` | `string` | `"mouse2"` |

## Tips

- Always add `id` to elements you need to read — elements without `id` (`mk_label`, `mk_sec`) are invisible to `all_elements`
- Keep `id` names unique across all tabs and columns — duplicates will overwrite each other in `all_elements`
- Cache `all_elements["id"]` into a local variable at the top of `on_frame` if you read it more than once
- Colors are `{r, g, b, a}` with all values in `0.0–1.0` range — not `0–255`
- For keybinds always use `str_to_vk()` to convert the stored string to a VK code before calling `input.is_key_down()`
- The `toggle_state` field in `HOTKEY_DEFS` persists across frames — do not reset it manually unless switching modes

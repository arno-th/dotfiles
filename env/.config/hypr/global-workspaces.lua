-- Global workspaces: one shared set, 1-10, across every monitor, the way
-- Omarchy worked before 4.5 made workspaces per monitor.
--
-- Super + 1 goes to workspace 1 on whichever monitor has it, and only creates
-- it on the focused monitor when it doesn't exist yet. That is plain Hyprland
-- behaviour, so this module just does the plain thing.
--
-- It stands in for Omarchy's default.hypr.monitor-workspaces (see the preload in
-- hyprland.lua) and keeps the same interface, so Omarchy's default keybindings
-- and the keybindings menu keep working. It adds none of that module's hooks,
-- so workspaces are never renumbered into per-monitor blocks.
--
-- If an Omarchy update starts calling something new on o.workspaces, add it
-- here. Compare against $OMARCHY_PATH/default/hypr/monitor-workspaces.lua.

local M = { slots = 10 }

-- Bind actions are functions; the keybindings menu replays them through
-- `hyprctl dispatch <expression>`, so record the expression for each.
local function action(fn, expression)
  o.bind_expressions[fn] = expression
  return fn
end

local function literal(value)
  if value == nil then
    return "nil"
  end
  return string.format("%q", value)
end

-- Workspace numbers are global, so a slot is its own id.
function M.workspace_id(_, slot)
  return slot
end

-- Go to a workspace wherever it is. A monitor name (the bar passes its own)
-- only says where to create it if it doesn't exist yet.
function M.focus(slot, monitor_name)
  return action(function()
    if monitor_name and not hl.get_workspace(slot) and hl.get_monitor(monitor_name) then
      hl.dispatch(hl.dsp.focus({ monitor = monitor_name }))
    end
    hl.dispatch(hl.dsp.focus({ workspace = tostring(slot) }))
  end, "o.workspaces.focus(" .. slot .. (monitor_name and ", " .. literal(monitor_name) or "") .. ")")
end

-- Move the active window to a workspace, following it unless `follow` is false.
function M.move_window(slot, follow)
  return action(function()
    hl.dispatch(hl.dsp.window.move({ workspace = tostring(slot), follow = follow ~= false }))
  end, "o.workspaces.move_window(" .. slot .. (follow == false and ", false" or "") .. ")")
end

-- Move the active workspace, number and all, to the monitor in a direction.
function M.move_to_monitor(direction)
  return action(function()
    -- Hyprland reports a move toward no monitor as an error on screen.
    local target = hl.get_monitor(direction)
    if target then
      hl.dispatch(hl.dsp.workspace.move({ monitor = target.name }))
    end
  end, "o.workspaces.move_to_monitor(" .. literal(direction) .. ")")
end

-- Move the focused window onto the workspace the monitor in that direction
-- shows, and follow it there.
function M.move_window_to_monitor(direction)
  return action(function()
    local target = hl.get_monitor(direction)
    if target then
      hl.dispatch(hl.dsp.window.move({ monitor = target.name }))
    end
  end, "o.workspaces.move_window_to_monitor(" .. literal(direction) .. ")")
end

-- Nothing to reconcile: Hyprland's own handling of monitors coming and going
-- is the old behaviour.
function M.reconcile() end

o.workspaces = M

return M

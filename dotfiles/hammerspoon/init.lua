-- disable animations to speed up the window movements
hs.window.animationDuration = 0

-- Setup Hyper key
-- http://evantravers.com/articles/2020/06/08/hammerspoon-a-better-better-hyper-key/
local hyper = hs.hotkey.modal.new({}, nil)

hyper.pressed = function()
  hyper:enter()
end

hyper.released = function()
  hyper:exit()
end

-- Set the key you want to be HYPER to F19 in karabiner or keyboard
-- Bind the Hyper key to the hammerspoon modal
hs.hotkey.bind({}, 'f19', hyper.pressed, hyper.released)

-- move window to the screen the mouse is on,
-- sizing to take up the left half
function windowLeft ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = hs.mouse.getCurrentScreen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:moveToScreen(screen)
  win:setFrame(f)
end

hs.hotkey.bind({"cmd", "alt"}, "Left", windowLeft)
hs.hotkey.bind({"cmd", "alt"}, "H", windowLeft)
hyper:bind({}, "h", windowLeft)

-- move window to the screen the mouse is on,
-- sizing to take up the right half
function windowRight ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = hs.mouse.getCurrentScreen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:moveToScreen(screen)
  win:setFrame(f)
end

hs.hotkey.bind({"cmd", "alt"}, "Right", windowRight)
hs.hotkey.bind({"cmd", "alt"}, "L", windowRight)
hyper:bind({}, "L", windowRight)

-- move window to the screen the mouse is on,
-- sizing to take up the right half
function windowMaximize()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = hs.mouse.getCurrentScreen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:moveToScreen(screen)
  win:setFrame(f)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", windowMaximize)
hyper:bind({}, "M", windowMaximize)

-- 'Lock' by starting the screensaver (which I have configured to require
-- my password to dismiss). This is prettier than the lock screen, and doesn't
-- do the silly cube-transform to the login screen.
hs.hotkey.bind({"cmd", "alt", "shift"}, "L", function()
  hs.caffeinate.startScreensaver()
end)

-- Reload this config file
hyper:bind({}, "R", hs.reload)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", hs.reload)

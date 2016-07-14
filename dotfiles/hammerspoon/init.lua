-- disable animations to speed up the window movements
hs.window.animationDuration = 0

-- move window to the screen the mouse is on,
-- sizing to take up the left half
hs.hotkey.bind({"cmd", "alt"}, "Left", function()
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
end)

-- move window to the screen the mouse is on,
-- sizing to take up the right half
hs.hotkey.bind({"cmd", "alt"}, "Right", function()
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
end)

-- move window to the screen the mouse is on,
-- sizing to take up the right half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
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
end)

-- 'Lock' by starting the screensaver (which I have configured to require
-- my password to dismiss). This is prettier than the lock screen, and doesn't
-- do the silly cube-transform to the login screen.
hs.hotkey.bind({"cmd", "alt"}, "L", function()
  hs.caffeinate.startScreensaver()
end)

-- Reload this config file
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

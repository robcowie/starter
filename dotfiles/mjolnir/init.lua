local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local alert = require "mjolnir.alert"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local grid = require "mjolnir.sd.grid"
local notification = require "mjolnir._asm.ui.notification"

-- NOTES
-- http://thume.ca/howto/2014/12/02/using-mjolnir-an-extensible-osx-window-manager/
-- https://github.com/Linell/mjolnir-config/blob/master/init.lua GOOD
-- https://rocks.moonscript.org/search?q=mjolnir

-- Set compass grid
grid.GRIDWIDTH  = 2
grid.GRIDHEIGHT = 2
grid.MARGINX = 0
grid.MARGINY = 0


local mash = {"cmd", "alt", "ctrl"}

-- a helper function that returns another function that resizes the current window
-- to a certain grid size.
local gridset = function(x, y, w, h)
    return function()
        cur_window = window.focusedwindow()
        grid.set(
            cur_window,
            {x=x, y=y, w=w, h=h},
            cur_window:screen()
        )
    end
end


-- Toggle fullscreen
hotkey.bind(mash, 'F', function()
    local isfull = window.focusedwindow():isfullscreen()
    window.focusedwindow():setfullscreen(not isfull)
end)

-- Example notification
hotkey.bind(mash, 'a', function()
  local cb = function(n)
    n:withdraw()
    n:release()
  end

  local noti = notification.new(cb, {
    title = 'bar',
    subtitle = 'testing',
    informativeText = 'informative text',
    -- actionButtonTitle = 'clickme',
    -- otherButtonTitle = 'cancel'
    })
  noti:send()
end)

hotkey.bind(mash, 'r', mjolnir.reload)
hotkey.bind(mash, 'M', grid.maximize_window)
hotkey.bind(mash, 'pad5', grid.maximize_window)

-- Arrows
hotkey.bind(mash, 'left', gridset(0, 0, 1, 2)) -- left half
hotkey.bind(mash, 'right', gridset(1, 0, 1, 2)) -- right half
hotkey.bind(mash, 'up', gridset(0, 0, 2, 1)) -- top half
hotkey.bind(mash, 'down', gridset(0, 1, 2, 1)) -- bottom half

-- Numpad
hotkey.bind(mash, 'pad4', gridset(0, 0, 1, 2)) -- left half
hotkey.bind(mash, 'pad6', gridset(1, 0, 1, 2)) -- right half
hotkey.bind(mash, 'pad8', gridset(0, 0, 2, 1)) -- top half
hotkey.bind(mash, 'pad2', gridset(0, 1, 2, 1)) -- bottom half
hotkey.bind(mash, 'pad7', gridset(0, 0, 1, 1)) -- top left quad
hotkey.bind(mash, 'pad9', gridset(1, 0, 1, 1)) -- top right quad
hotkey.bind(mash, 'pad1', gridset(0, 1, 1, 1)) -- bottom left quad
hotkey.bind(mash, 'pad3', gridset(1, 1, 1, 1)) -- bottom right quad

-- Screen movement
hotkey.bind(mash, 'n', grid.pushwindow_nextscreen) -- push to next window
-- hotkey.bind(mash, 'p', grid.pushwindow_prevscreen) -- push to previous window

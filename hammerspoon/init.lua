-- Disable animation for instant resizing
hs.window.animationDuration = 0

-- Focus next monitor: Cmd + Option + N
hs.hotkey.bind({ "cmd", "option" }, "n", function()
	local screen = hs.mouse.getCurrentScreen()
	local nextScreen = screen:next()
	local rect = nextScreen:fullFrame()
	local center = hs.geometry.rectMidPoint(rect)
	hs.mouse.setAbsolutePosition(center)
	hs.eventtap.leftClick(center)
end)

-- Window Management
local sizes = { 1/2, 1/3, 2/3 }
local lastAction = {}

local function cycleMove(direction)
	local win = hs.window.focusedWindow()
	if not win then return end

	local screen = win:screen():frame()
	local winId = win:id()
	local key = winId .. direction

	-- Cycle through sizes
	local idx = (lastAction[key] or 0) % #sizes + 1
	lastAction[key] = idx
	local size = sizes[idx]

	local frame = {}
	if direction == "left" then
		frame = { x = screen.x, y = screen.y, w = screen.w * size, h = screen.h }
	elseif direction == "right" then
		frame = { x = screen.x + screen.w * (1 - size), y = screen.y, w = screen.w * size, h = screen.h }
	elseif direction == "up" then
		frame = { x = screen.x, y = screen.y, w = screen.w, h = screen.h * size }
	elseif direction == "down" then
		frame = { x = screen.x, y = screen.y + screen.h * (1 - size), w = screen.w, h = screen.h * size }
	end

	win:setFrame(frame)
end

-- Halves (with cycling): Option + Cmd + Arrow
hs.hotkey.bind({ "option", "cmd" }, "left", function() cycleMove("left") end)
hs.hotkey.bind({ "option", "cmd" }, "right", function() cycleMove("right") end)
hs.hotkey.bind({ "option", "cmd" }, "up", function() cycleMove("up") end)
hs.hotkey.bind({ "option", "cmd" }, "down", function() cycleMove("down") end)

local function moveWindow(x, y, w, h)
	local win = hs.window.focusedWindow()
	if not win then return end
	local screen = win:screen():frame()
	win:setFrame({
		x = screen.x + (screen.w * x),
		y = screen.y + (screen.h * y),
		w = screen.w * w,
		h = screen.h * h,
	})
end

-- Quarters: Option + Cmd + U/I/J/K
hs.hotkey.bind({ "option", "cmd" }, "u", function() moveWindow(0, 0, 0.5, 0.5) end)
hs.hotkey.bind({ "option", "cmd" }, "i", function() moveWindow(0.5, 0, 0.5, 0.5) end)
hs.hotkey.bind({ "option", "cmd" }, "j", function() moveWindow(0, 0.5, 0.5, 0.5) end)
hs.hotkey.bind({ "option", "cmd" }, "k", function() moveWindow(0.5, 0.5, 0.5, 0.5) end)

-- Maximize: Option + Cmd + Return
hs.hotkey.bind({ "option", "cmd" }, "return", function() moveWindow(0, 0, 1, 1) end)

-- Move window to next monitor: Option + Cmd + M
hs.hotkey.bind({ "option", "cmd" }, "m", function()
	local win = hs.window.focusedWindow()
	if win then win:moveToScreen(win:screen():next()) end
end)

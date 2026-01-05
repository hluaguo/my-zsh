-- Disable animation for instant resizing
hs.window.animationDuration = 0

-- SketchyBar height offset
BAR_HEIGHT = 50
GAP = 10

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
local sizes = { 1 / 2, 1 / 3, 2 / 3 }
local lastAction = {}

local function cycleMove(direction)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local f = win:screen():fullFrame()
	local screen = { x = f.x + GAP, y = f.y + BAR_HEIGHT, w = f.w - GAP * 2, h = f.h - BAR_HEIGHT - GAP }
	local winId = win:id()
	local key = winId .. direction

	-- Cycle through sizes
	local idx = (lastAction[key] or 0) % #sizes + 1
	lastAction[key] = idx
	local size = sizes[idx]

	local halfGap = GAP / 2
	local frame = {}
	if direction == "left" then
		frame = { x = screen.x, y = screen.y, w = screen.w * size - halfGap, h = screen.h }
	elseif direction == "right" then
		frame = { x = screen.x + screen.w * (1 - size) + halfGap, y = screen.y, w = screen.w * size - halfGap, h = screen.h }
	elseif direction == "up" then
		frame = { x = screen.x, y = screen.y, w = screen.w, h = screen.h * size - halfGap }
	elseif direction == "down" then
		frame = { x = screen.x, y = screen.y + screen.h * (1 - size) + halfGap, w = screen.w, h = screen.h * size - halfGap }
	end

	win:setFrame(frame)
end

-- Halves (with cycling): Option + Cmd + Arrow
hs.hotkey.bind({ "option", "cmd" }, "left", function()
	cycleMove("left")
end)
hs.hotkey.bind({ "option", "cmd" }, "right", function()
	cycleMove("right")
end)
hs.hotkey.bind({ "option", "cmd" }, "up", function()
	cycleMove("up")
end)
hs.hotkey.bind({ "option", "cmd" }, "down", function()
	cycleMove("down")
end)

local function moveWindow(x, y, w, h)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end
	local f = win:screen():fullFrame()
	local screen = { x = f.x + GAP, y = f.y + BAR_HEIGHT, w = f.w - GAP * 2, h = f.h - BAR_HEIGHT - GAP }
	win:setFrame({
		x = screen.x + (screen.w * x),
		y = screen.y + (screen.h * y),
		w = screen.w * w,
		h = screen.h * h,
	})
end

-- Quarters with gaps: Option + Cmd + U/I/J/K
local function moveQuarter(pos)
	local win = hs.window.focusedWindow()
	if not win then return end
	local f = win:screen():fullFrame()
	local halfGap = GAP / 2
	local x = f.x + GAP
	local y = f.y + BAR_HEIGHT
	local w = (f.w - GAP * 2 - GAP) / 2
	local h = (f.h - BAR_HEIGHT - GAP - GAP) / 2

	local frame = {}
	if pos == "tl" then
		frame = { x = x, y = y, w = w, h = h }
	elseif pos == "tr" then
		frame = { x = x + w + GAP, y = y, w = w, h = h }
	elseif pos == "bl" then
		frame = { x = x, y = y + h + GAP, w = w, h = h }
	elseif pos == "br" then
		frame = { x = x + w + GAP, y = y + h + GAP, w = w, h = h }
	end
	win:setFrame(frame)
end

hs.hotkey.bind({ "option", "cmd" }, "u", function() moveQuarter("tl") end)
hs.hotkey.bind({ "option", "cmd" }, "i", function() moveQuarter("tr") end)
hs.hotkey.bind({ "option", "cmd" }, "j", function() moveQuarter("bl") end)
hs.hotkey.bind({ "option", "cmd" }, "k", function() moveQuarter("br") end)

-- Maximize: Option + Cmd + Return
hs.hotkey.bind({ "option", "cmd" }, "return", function()
	moveWindow(0, 0, 1, 1)
end)

-- Move window to next monitor (maximized): Option + Cmd + M
hs.hotkey.bind({ "option", "cmd" }, "m", function()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end
	local nextScreen = win:screen():next()
	local f = nextScreen:fullFrame()
	win:moveToScreen(nextScreen)
	win:setFrame({ x = f.x + GAP, y = f.y + BAR_HEIGHT, w = f.w - GAP * 2, h = f.h - BAR_HEIGHT - GAP })
end)

-- App launcher
hs.hotkey.bind({ "option", "cmd" }, "t", function()
	hs.application.launchOrFocus("iTerm")
end)
hs.hotkey.bind({ "option", "cmd" }, "b", function()
	hs.application.launchOrFocus("Google Chrome")
end)
hs.hotkey.bind({ "option", "cmd" }, "s", function()
	hs.application.launchOrFocus("Slack")
end)

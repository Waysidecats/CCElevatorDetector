local detector = peripheral.find("playerDetector")
local scroll = 0
local players = {}

-- Helper to safely floor numbers
local function safeFloor(n)
  return (type(n) == "number") and math.floor(n) or "N/A"
end

-- Update list of online players
local function refreshPlayers()
  players = detector.getOnlinePlayers() or {}
  table.sort(players) -- optional: alphabetical
end

-- Display player info starting from scroll offset
local function display()
  term.clear()
  term.setCursorPos(1, 1)

  local screenW, screenH = term.getSize()
  local maxPerPage = screenH // 6

  for i = 1, maxPerPage do
    local index = i + scroll
    local username = players[index]

    if username then
      local pos = detector.getPlayerPos(username)
      if pos and pos.x ~= nil then
        print(username .. ": online")
        print("  Dim: " .. (pos.dimension or "N/A"))
        print("  Pos: X=" .. safeFloor(pos.x) ..
              " Y=" .. safeFloor(pos.y) ..
              " Z=" .. safeFloor(pos.z))
        print("  HP: " .. safeFloor(pos.health) ..
              "/" .. safeFloor(pos.maxHealth))
        print("  Air: " .. (pos.airSupply or "N/A"))
      else
        print(username .. ": online (no data)")
        print("")
        print("")
        print("")
        print("")
      end
    end
  end
end

-- Event handler for scrolling & joining
parallel.waitForAny(
  -- Listen for join/leave events and refresh
  function()
    while true do
      local event, username, dimension = os.pullEvent()
      if event == "playerJoin" or event == "playerLeave" then
        refreshPlayers()
        display()
      end
    end
  end,

  -- Handle arrow keys and mouse scroll
  function()
    while true do
      local event, p1 = os.pullEvent()
      local _, screenH = term.getSize()
      local maxScroll = math.max(0, #players - (screenH // 6))

      if event == "key" then
        local key = p1
        if key == keys.up and scroll > 0 then
          scroll = scroll - 1
          display()
        elseif key == keys.down and scroll < maxScroll then
          scroll = scroll + 1
          display()
        end

      elseif event == "mouse_scroll" then
        local direction = p1  -- 1 = down, -1 = up
        if direction == 1 and scroll < maxScroll then
          scroll = scroll + 1
          display()
        elseif direction == -1 and scroll > 0 then
          scroll = scroll - 1
          display()
        end
      end
    end
  end,

  -- Auto-refresh every few seconds
  function()
    while true do
      sleep(5)
      refreshPlayers()
      display()
    end
  end
)

-- Initial load
refreshPlayers()
display()

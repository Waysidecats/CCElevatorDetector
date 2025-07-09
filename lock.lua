local correctPassword = "password"

local function readPassword()
  local input = ""
  while true do
    local event, key = os.pullEventRaw()

    if event == "char" then
      input = input .. key
      io.write("*")
    elseif event == "key" then
      if key == keys.enter then
        print()
        return input
      elseif key == keys.backspace and #input > 0 then
        input = input:sub(1, -2)
        local x, y = term.getCursorPos()
        term.setCursorPos(x - 1, y)
        io.write(" ")
        term.setCursorPos(x - 1, y)
      end
    end
    -- Ignore terminate (Ctrl+T)
  end
end

term.clear()
term.setCursorPos(1, 1)

while true do
  local pw = readPassword()
  if pw == correctPassword then
    shell.run("activate")
    break
  end
end

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

local function printCentered(text, y)
  local w, _ = term.getSize()
  local x = math.floor((w - #text) / 2) + 1
  term.setCursorPos(x, y)
  term.write(text)
end

while true do
  term.clear()
  term.setCursorPos(1,1)
  print("+-----------------------+")
  print("|    ENTER PASSWORD     |")
  print("+-----------------------+")
  term.setCursorPos(1,5)
  io.write("> ")
  local pw = readPassword()
  if pw == correctPassword then
    term.clear()
    term.setCursorPos(1,1)
    print("+-----------------------+")
    print("|     ACCESS GRANTED    |")
    print("+-----------------------+")
    sleep(1.5)
    shell.run("activate")
    break
  else
    term.clear()
    term.setCursorPos(1,1)
    print("+-----------------------+")
    print("|    INCORRECT PASSWORD |")
    print("+-----------------------+")
    sleep(1.5)
  end
end

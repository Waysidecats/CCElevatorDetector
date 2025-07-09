m = peripheral.find('monitor')
p = peripheral.find('playerDetector')

x1 = 0
x2 = 0
y1 = 0
y2 = 0
z1 = 0
z2 = 0

m.setTextScale(5)
m.clear()

function isPlayer ()
  x = p.getPlayersInCubic(x1,y1,z1,x2,y2,z2)
  if x ~= nil then
    return true
  else
    return false
  end
end

function monitor (num)
  m.clear()
  m.setCursorPos(1,1)
  m.write(string.format(num))
  os.sleep(1)
  if isPlayer() then
    return true
  else
    return false
  end
end

while true do
  if isPlayer() then
    continue = true
    num = 5
    while num>0 and continue do
      continue = monitor(num)
      num = num - 1
      print(num)
    end
  end
end
    

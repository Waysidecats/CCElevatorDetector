m = peripheral.find('monitor')
p = peripheral.find('playerDetector')

redstoneSide = 'back'
pos1 = (0,0,0)
pos2 = (0,0,0)

m.setTextScale(5)
m.clear()

function isPlayer ()
  x = p.getPlayersInCoords(pos1,pos2)
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
    m.clear()
    redstone.setOutput(redstoneSide, true)
    os.sleep(3)
    redstone.setOutput(redstoneSide, false)
    m.clear()
  end
end
    

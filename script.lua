m = peripheral.find('monitor')
p = peripheral.find('playerDetector')

redstoneSide = 'back'
pos1 = {x=0, y=0, z=0}
pos2 = {x=0, y=0, z=0}
delay = 5

m.setTextScale(5)
m.clear()

function isPlayer ()
  x = p.getPlayersInCoords(pos1,pos2)
  return x ~= nil and #x > 0
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
    num = delay
    while num>0 and continue do
      continue = monitor(num)
      num = num - 1
      print(num)
    end
    m.clear()
    if continue then
      redstone.setOutput(redstoneSide, true)
      os.sleep(3)
      redstone.setOutput(redstoneSide, false)
      m.clear()
    end
  end
end
    

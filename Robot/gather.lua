local robot = require("robot")

--[[
function replant()
  robot.down()
  robot.select(16)
  robot.use()
end
]]

function replantRow(length)
  for i=1, length-1 do
    robot.use()
    robot.forward()
  end
  robot.use()
end

args={...}

robot.up()
robot.use()
robot.forward()
semiarg = args[2] / 2

-- Двигаемся до последнего ряда
for i=1, semiarg do
        replantRow(args[1])
        robot.turnLeft()
        robot.use()
		robot.forward()
        robot.turnLeft()
        replantRow(args[1])
        robot.turnRight()
        robot.use()
        robot.forward()
        robot.turnRight()
end

-- Проверяем четное или не четное количество рядов.
if semiarg * 2 ~= args[2] then

-- Не четное, значит доезжаем последний ряд
    replantRow(args[1])

-- Возвращаем робота на финишную прямую
    robot.turnAround()
        for i=1, args[1] do
            robot.forward()
        end
-- Четное, Возвращаем робота на финишную прямую
    else
    robot.turnAround()
    robot.forward()
end

-- Финишная прямая, возвращаемся обратно
robot.turnLeft()
for i=1, args[2]-1 do
    robot.forward()
end
robot.down()

-- Выгружаем инвентрарь
for i=1, 15 do
        robot.select(i)
        if robot.count(i) > 0 then
            robot.drop()
        end
end

-- На исходную
robot.turnLeft()
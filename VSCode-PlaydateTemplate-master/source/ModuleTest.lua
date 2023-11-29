
class("ModuleTest").extends()
local score = 0

function ModuleTest:printHi()
    print("Hi" .. score)
end

function printHi()
    print("better hi" .. score)
end

function ModuleTest:addScore()
    score += 1
end

function ModuleTest:getScore()
    return score
end
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = pd.graphics

local playerX, playerY = 200, 120
local originalPlayerX, originalPlayerY = playerX, playerY
local playerRadius = 10
local playerSpeed = 3

local screenWidth = 400
local screenHeight = 240
local screenShakeIntensity = 5

local filePlayer= pd.sound.fileplayer.new("Sounds/TheWorstPolyphia", 5)
--filePlayer:load("Sounds/TheWorstPolyphia.wav")
filePlayer:play(3)
filePlayer:setVolume(1.0)


function  pd.update()
    gfx.clear()
    local crankAngle = math.rad(pd.getCrankPosition())
    local newX = playerX + math.sin(crankAngle) * playerSpeed
    local newY = playerY - math.cos(crankAngle) * playerSpeed

    -- Check if the new position is out of the screen bounds
    if newX - playerRadius < 0 or newX + playerRadius > screenWidth or newY - playerRadius < 0 or newY + playerRadius > screenHeight then
        -- Perform screen shake
        performScreenShake()
    else
        playerX, playerY = newX, newY
        originalPlayerX, originalPlayerY = playerX, playerY
    end

    gfx.fillCircleAtPoint(playerX, playerY, playerRadius)
end

function performScreenShake()
    local xOffset = (math.random() * 2 - 1) * screenShakeIntensity
    local yOffset = (math.random() * 2 - 1) * screenShakeIntensity
    playerX = originalPlayerX + xOffset
    playerY = originalPlayerY + yOffset

    gfx.fillCircleAtPoint(playerX, playerY, playerRadius)
end
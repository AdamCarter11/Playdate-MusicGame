import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- anything below this comment can be rewritten/changed/deleted
local playerX, playerY = 200, 120
local originalPlayerX, originalPlayerY = playerX, playerY
local playerRadius = 10
local playerSpeed = 3

-- screen dimensions for the playdate are 400x240
local screenWidth = 400
local screenHeight = 240
local screenShakeIntensity = 5

local filePlayer= pd.sound.fileplayer.new("Sounds/TheWorstPolyphia", 5)
--filePlayer:load("Sounds/TheWorstPolyphia.wav")
filePlayer:play(3)
filePlayer:setVolume(1.0)

-- an array of key inputs keyed to matching strings so we can use it to determine sprite spawn
local keyInputs = {
    playdate.kButtonUp,
    playdate.kButtonRight,
    playdate.kButtonDown,
    playdate.kButtonLeft
}
-- timer has to be created above the update cause update has to recall this
local timerInterval = 3 * 600
function SpawnArrow()
    print("spawn arrow")
end
local spawnTimer = pd.timer.new(timerInterval, SpawnArrow)
spawnTimer.repeats = true
spawnTimer:start()

-- define image vars globally so the sprite setup function can access them
local testImge
local arrowLeftSprite
local colorTestSprite

-- main game logic functions
-- start is called at the very end to make sure all necessary functions have been made
function Start()
    -- testImge = gfx.image.new("Sprites/TestPlaydateSprite")
    -- assert(testImge) -- make sure image was loaded correctly
    -- SpriteSetup(testImge, 100, 100, 2)

    local bgImage = gfx.image.new("Sprites/StartEmpty")
    assert(bgImage)
    --[[
    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            bgImage:draw(0,0)
        end
    )
    ]]
    local colorTestImage = gfx.image.new("Sprites/ColorTest")
    assert(colorTestImage)
    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            colorTestImage:draw(0,0)
        end
    )

    local arrowLeft = gfx.image.new("Sprites/LeftArrow")
    assert(arrowLeft)
    arrowLeftSprite = gfx.sprite.new(arrowLeft)
    arrowLeftSprite:moveTo(400,120)
    arrowLeftSprite:add()

    
end

function  pd.update()
    -- clear the screen before redrawing
    gfx.clear()

    -- just testing stuff with this function
    -- CheckMoveShake()

    arrowLeftSprite:moveBy(-2,0)
    --[[
    local randoDir = keyInputs[math.random(1, #keyInputs)]
    if pd.buttonIsPressed(randoDir) then
        print("pressed correct button")
    end
    ]]
    if pd.buttonIsPressed(pd.kButtonLeft) and arrowLeftSprite.x < 150 then
        print("correct button pressed")
    end

   
    -- draw the needed sprites
    drawSprites()

    -- update timers
    pd.timer.updateTimers()
end

function drawSprites()
    gfx.sprite.update()
    -- gfx.fillCircleAtPoint(playerX, playerY, playerRadius)
end

-- extra functions
function CheckMoveShake()
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
end

function performScreenShake()
    local xOffset = (math.random() * 2 - 1) * screenShakeIntensity
    local yOffset = (math.random() * 2 - 1) * screenShakeIntensity
    playerX = originalPlayerX + xOffset
    playerY = originalPlayerY + yOffset

    gfx.fillCircleAtPoint(playerX, playerY, playerRadius)
end


-- unfortunately, we need a sprite var as it acts as the obj var, so this function won't work
    -- a function I created, it defaults sprite dim to 32x32, but you can type a 5 parameter in for the dimension
    -- ex: SpriteSetup(testImge, posX, posY, scaleMulti, 64) 64 is the sprite dimensions
    function SpriteSetup(image, posX, posY, scaleMulti, spriteDim)
        if spriteDim == nil then
           spriteDim = 32 
        end
        tempSprite = gfx.sprite.new(image)
        tempSprite:moveTo(posX,posY)
        local tempScale = 3
        -- really janky, but the scale is what actually sets the size
        tempSprite:setScale(scaleMulti,scaleMulti)
        -- set size sets the max area the sprite can take
        -- 32x32 is this sprites size, then we multi it by scale to increase its actual size in the playdate
        tempSprite:setSize(32*scaleMulti,32*scaleMulti)
        tempSprite:add()
    end



-- call start
Start()
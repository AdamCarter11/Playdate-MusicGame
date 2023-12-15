import "NoteSpawner"
import "scoreDisplay"
import "Player"
import "Pen"
import "WaveSpawner"
import "soundModule"
import "WallCollider"
import "sceneManager"
import "menuScene"
import "gameOverScene"
import "ModuleTest"

local pd <const> = playdate
local gfx <const> = pd.graphics

--local noteSpawnerObj = require ("NoteSpawner")
--print(lfs.currentdir())
--require("ModuleTest")

class('GameScene').extends(gfx.sprite)

-- Starting Positions/Values
local SCREEN_X = 400
local SCREEN_Y = 240
local PADDING = 15
local PLAYER_X_POS = 30
local PLAYER_Y_POS = 120
local WAVE_START_Y = 215
local WAVE_LENGTH = 200
local WAVE_AMP = 3
local WAVE_PERIOD = 100
local WAVE_SPEED = 1
local switchTrans = false
local startTime = false
local pauseTime = 15
local wavePauseTime = 17
local health = 4

function GameScene:init()
    local backgroundImage = gfx.image.new("Sprites/Radio Recording Room")
    local boarderLeft = gfx.image.new("Sprites/BiggerBoarder")
    local boarderRight = gfx.image.new("Sprites/EvenBiggerBoarder")

    backgroundSprite = gfx.sprite.new(backgroundImage)
    backgroundSprite:moveTo(200,120)
    backgroundSprite:add()

    boarderLeftImg = gfx.sprite.new(boarderLeft)
    boarderLeftImg:moveTo(95,10)
    boarderLeftImg:add()

    boarderRightImg = gfx.sprite.new(boarderRight)
    boarderRightImg:moveTo(340,10)
    boarderRightImg:add()
    --printHi()
    --ModuleTest:printHi()
    createScoreDisplay()
    -- Spawn player
    Player (PLAYER_X_POS, PLAYER_Y_POS)
    -- Enemy(400, 120, 1)
    Player(51, 171, gfx.image.new("Sprites/Arrow"))
    ABPlayer(51, 189, gfx.image.new("Sprites/Button"))

    -- Spawn the waves from the right of the screen
    WAVE_PERIOD = math.random(60,140)
    WaveSpawner (SCREEN_X, WAVE_START_Y, WAVE_LENGTH, WAVE_AMP, WAVE_PERIOD, WAVE_SPEED)
    TurnSoundOn()

    startSpawner()

    self:add()
end

function GameScene.update()
    --print(startTime)
    gfx.sprite.update()
    --ModuleTest:addScore()
    --ModuleTest:printHi()
    --printHi()
	-- if pd.buttonJustPressed(pd.kButtonA) then
    --     SCENE_MANAGER:switchScene(GameOverScene, "Score: 10")
    -- end
    
    if (startTime) then
        if(math.floor(pd.getElapsedTime()) % 20 == 0 and switchTrans == false) then
            switchTrans = true
            TurnOffSpawner()
            TurnSoundOff()
            TurnOffWave()
            -- heres an example of how we can turn off the spawner
                -- I also made a TurnOnSpawner() that can be called in the same way anywhere in this script
                -- refer to line 28 for how I got access to the object like this
            --noteSpawnerObj.TurnOffSpawner()
        end
        if(math.floor(pd.getElapsedTime()) % pauseTime == 0 and switchTrans == false) then
            pauseTime += 20
            TurnOffSpawner()
            TurnSoundOff()
            print("timer stopped")
        end
        if(math.floor(pd.getElapsedTime()) % wavePauseTime == 0 and switchTrans == false) then
            wavePauseTime += 20
            TurnOffWave()
            TurnSoundOff()
            print("wave timer stopped")
        end
    end
    

    if(switchTrans == true) then
        Switch()
    end
end

--#region == Helper Functions ==
function Switch()
    playdate.gameWillResume()
end

function playdate.gameWillResume()

	-- save off the current playdate.update so we can restore it at the end of the countdown
	local saveOffUpdate = playdate.update
	
	playdate.update = 
	function()	
		
		-- draw the countdown
        gfx.clear()
        gfx.drawText( "SWAP!", 180, 100  )
		playdate.wait( 1000 )
		gfx.clear()
		gfx.drawText( "3", 200, 100 )
		playdate.wait( 1000 )
		gfx.clear()
		gfx.drawText( "2", 200, 100 )
		playdate.wait( 1000 )
		gfx.clear()
		gfx.drawText( "1", 200, 100 )
		playdate.wait( 1000 )
		gfx.clear()
        gfx.drawText( "GO!", 180, 100 )
		playdate.wait( 1000 )
		gfx.clear()
        switchTrans = false
        TurnOnSpawner()
        TurnOnWave()
        WAVE_PERIOD = math.random(80,120)
        print("timer started")
		
		-- restore the "real" playdate.update
		playdate.update = saveOffUpdate
        
        -- resume sound
        TurnSoundOn()
	end
		
end

--#endregion

function changeHealth(changeVal)
    health -= changeVal
    if health <= 0 then
        SCENE_MANAGER:switchScene(GameOverScene, returnScore())
    end
end

function resetHealth()
    health = 4
end

function resetPauseTime()
    pauseTime = 15
end

function startSwapTime()
    startTime = true
end
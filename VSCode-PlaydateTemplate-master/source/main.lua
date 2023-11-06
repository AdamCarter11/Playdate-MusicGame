import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

-- other classes (objs)
import "Player"
-- import "Enemy"
-- import "enemySpawner"
import "NoteSpawner"
import "scoreDisplay"

-- reference: https://www.youtube.com/watch?v=BG-pbLrY3ro&ab_channel=SquidGod

local pd <const> = playdate
local snd <const> = pd.sound
local gfx <const> = pd.graphics


function resetGame()
    resetScore()
    clearEnemies()
    stopSpawner()
    startSpawner()
end

createScoreDisplay()
Player(30, 120)
-- Enemy(400, 120, 1)
startSpawner()

function Start()
    
end

function  pd.update()
    -- clear the screen before redrawing
    gfx.clear()
   
    -- draw the needed sprites
    drawSprites()

    -- update timers
    pd.timer.updateTimers()
end

function drawSprites()
    gfx.sprite.update()
    -- gfx.fillCircleAtPoint(playerX, playerY, playerRadius)
end


-- call start
Start()
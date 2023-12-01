
import "sceneManager"
import "gameScene"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('MenuScene').extends(gfx.sprite)


function MenuScene:init()
    local backgroundImage = gfx.image.new("Sprites/StartEmpty")
    --gfx.sprite.setBackgroundDrawingCallback(function ()backgroundImage:draw(0,0) end)
    --backgroundSprite:moveTo(0,0)
    backgroundSprite = gfx.sprite.new(backgroundImage)
    backgroundSprite:moveTo(200,120)
    backgroundSprite:add()

    self:add()

end

function MenuScene.update()
    if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameScene)
        startSwapTime()
        pd.resetElapsedTime()
        resetPauseTime()
        TurnOnSpawner()
    end
end
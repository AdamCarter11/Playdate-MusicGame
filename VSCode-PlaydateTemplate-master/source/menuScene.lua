
import "sceneManager"
import "gameScene"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('MenuScene').extends(gfx.sprite)


function MenuScene:init()
    local backgroundImage = gfx.image.new("Sprites/StartEmpty")
    local jamText = gfx.image.new("Sprites/PressAToJam")
    --gfx.sprite.setBackgroundDrawingCallback(function ()backgroundImage:draw(0,0) end)
    --backgroundSprite:moveTo(0,0)
    backgroundSprite = gfx.sprite.new(backgroundImage)
    backgroundSprite:moveTo(200,120)
    backgroundSprite:add()

    jamSprite = gfx.sprite.new(jamText)
    jamSprite:moveTo(330,50)
    jamSprite:add()

    self:add()

end

function MenuScene.update()
    if pd.buttonJustPressed(pd.kButtonA) and not returnTransitionState() then
        print("start game")
        SCENE_MANAGER:switchScene(GameScene)
        startSwapTime()
        pd.resetElapsedTime()
        resetPauseTime()
        TurnOnSpawner()
    end
end
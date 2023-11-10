

import "sceneManager"
import "gameScene"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('MenuScene').extends(gfx.sprite)

function MenuScene:init()
    local backgroundSprite = gfx.sprite.new("Sprites/StartEmpty")
    -- gfx.sprite.setBackgroundDrawingCallback(function ()backgroundImage:draw(0,0) end)
    backgroundSprite: moveTo(0,0)
    backgroundSprite:add()

    self:add()

end

function MenuScene.update()
    if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameScene)
    end
end
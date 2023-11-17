import "Bullet"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('ABPlayer').extends(gfx.sprite)

function ABPlayer:init(x,y, playerImage)
    --local playerImage = gfx.image.new("Sprites/LeftArrow")
    self:setImage(playerImage)
    self:moveTo(x,y)
    self:add()
    self.speed = 3
end

function ABPlayer:update()
    --[[ if pd.buttonIsPressed(pd.kButtonUp) then
        if self.y > 0 then
            self:moveBy(0, -self.speed)
        end
    end
    if pd.buttonIsPressed(pd.kButtonDown) then
        if self.y < 240 then
            self:moveBy(0, self.speed)
        end
    end ]]

    if pd.buttonJustPressed(pd.kButtonA) then
        Bullet(self.x, self.y, 5)
    end
end
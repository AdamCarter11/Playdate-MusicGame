local pd <const> = playdate
local gfx <const> = pd.graphics

class('Pen').extends(gfx.sprite)

local X_POS = 10
local Y_MAX = 55
local Y_MIN = 5

function Pen:init(moveSpeed)
    local penImage = gfx.image.new("Sprites/disk_1")
    self:setImage(penImage)
    self:moveTo(X_POS, abs(Y_MAX-Y_MIN)/2)
    self:add()

    self:setCollideRect(0, 0, self:getSize())

    self.moveSpeed = moveSpeed
end

-- NOTE: we care about:
--   getCrankPosition() - for float position from range 0-359.9999
--      as the crank changes from starting position to clockwise
--      rotation back to starting position
--   getCrankChange() - returns 2 values:
--    change: represents the angle change (in degrees) of the 
--      crank since the last time this function (or the 
--      playdate.cranked() callback) was called. 
--      Negative values are anti-clockwise.
--    acceleratedChange is change multiplied by a value that 
--      increases as the crank moves faster, similar to the way
--      mouse acceleration works.

function Pen:update()
    if y + self:getSize()/2 > Y_MIN and y + self.getSize()/2 < Y_MAX then
        self:moveBy(0, self.moveSpeed)
    end
end

function Pen:setMoveSpeed()
    self.moveSpeed = pd.getCrankChange()
end

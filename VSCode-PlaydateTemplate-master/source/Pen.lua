local pd <const> = playdate
local gfx <const> = pd.graphics

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

class('Pen').extends(gfx.sprite)

function Pen:init(x, y, moveSpeed)
    local penImage = gfx.image.new("Sprites/Record")
    self:setImage(penImage)
    self:setCollideRect(0, 0, self:getSize())

    self.x = x
    self.y = y
    self.currentCrankAngle = math.rad(pd.getCrankPosition())
    self.moveSpeed = moveSpeed

    self:moveTo(x, y)
    self:add()
end

function Pen:update()
    -- Get current crank position
    crankAngle = math.rad(pd.getCrankPosition())

    -- Only move up or down
    -- self.tempX += math.sin(crankAngle) * self.moveSpeed
    self.y -= math.cos(crankAngle) * self.moveSpeed

    self:moveTo(self.x, self.y)
end

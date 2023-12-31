local pd <const> = playdate
local gfx <const> = pd.graphics
local snd <const> = pd.sound

class('Note').extends(gfx.sprite)

-- Define an array of sprite file paths
local spritePaths = {
    "Sprites/Arrow_R",
    "Sprites/Arrow_L",
    "Sprites/Arrow_Up",
    "Sprites/Arrow_Down",
    "Sprites/Button_A",
    "Sprites/Button_B"
}
-- define array of notes
local notes = {
    "Sounds/TestNotes/Note_1",
    "Sounds/TestNotes/Note_2",
    "Sounds/TestNotes/Note_3",
    "Sounds/TestNotes/Note_4",
    "Sounds/TestNotes/Note_5",
    "Sounds/TestNotes/Note_6",
    "Sounds/TestNotes/Note_7",
    "Sounds/TestNotes/Note_8",
    "Sounds/TestNotes/Note_9",
    "Sounds/TestNotes/Note_10",
    "Sounds/TestNotes/Note_11",
    "Sounds/TestNotes/Note_12",
    "Sounds/TestNotes/Note_13",
    "Sounds/TestNotes/Note_14",
    "Sounds/TestNotes/Note_15",
    "Sounds/TestNotes/Note_16",
}

-- Define a table that maps sprite paths to numbers
local spriteMap = {
    ["Sprites/Arrow_R"] = 1,
    ["Sprites/Arrow_L"] = 2,
    ["Sprites/Arrow_Up"] = 3,
    ["Sprites/Arrow_Down"] = 4,
    ["Sprites/Button_A"] = 5,
    ["Sprites/Button_B"] = 6,
}
-- define a table to associate sprite with key input
local actionMap = {
    [1] = pd.kButtonRight,
    [2] = pd.kButtonLeft,
    [3] = pd.kButtonUp, -- Add more mappings as needed
    [4] = pd.kButtonDown,
    [5] = pd.kButtonA,
    [6] = pd.kButtonB
}
local seqMap = {
    [1] = 1,
    [2] = 5,
    [3] = 9,
    [4] = 13
}

local seqCounter = 0

function Note:init(moveSpeed, whichNoteSeq)
    local randomIndex = math.random(1, #spritePaths)
    
    -- Load the randomly selected sprite image
    local spritePath = spritePaths[randomIndex]
    local noteImage = gfx.image.new(spritePath)
    local spriteNum = spriteMap[spritePath]

    self.spriteNumber = spriteNum
    self.whichButton = actionMap[spriteNum]
    self.whichSeq = whichNoteSeq

    self:setImage(noteImage)
    local x = 430
    local y = 0
    -- I'm adding 32 for each row for now as thats the sprite height
    if(spriteNum < 5) then
        y = 171
    end
    if(spriteNum >= 5) then
        y = 189
    end
    self:moveTo(x,y)
    self:add()

    self:setCollideRect(0, 0, self:getSize())

    self.moveSpeed = moveSpeed
    
end

function Note:update()
    self:moveBy(-self.moveSpeed, 0)
    -- 0 should be wherever we want the threshold to be
    if self.x < 5 then
        self:remove()
        -- play a bad note
        self:playNote(1)
        local currNote = pd.sound.fileplayer.new("Sounds/bad miss")
        changeHealth(1)
        currNote:play(1)
        resetStreak()
    end

    -- check if note was hit at right time
    --[[ if(self.x < 120 and self.x > 30 and pd.buttonJustPressed(self.whichButton)) then
        self:remove()
        -- play good note
        self:playNote(2)
    end ]]

    --check distance to player blocks
    if(self.x >= 44 and self.x <= 57 and pd.buttonJustPressed(self.whichButton)) then
        self:remove()
        self:playNote(2)
        local currNote = pd.sound.fileplayer.new(notes[5])
        currNote:setRate(2)
        currNote:play(1)
        addStreak()
        incrementScore(50)
        
        print("PERFECT")
        
    end
    if(self.x > 4 and self.x < 18 and pd.buttonJustPressed(self.whichButton)) then
        self:remove()
        self:playNote(1)
        local currNote = pd.sound.fileplayer.new("Sounds/bad miss")
        currNote:play(1)
        incrementScore(10)
        print("BAD")
        resetStreak()
    end

    if(self.x > 70 and self.x < 83 and pd.buttonJustPressed(self.whichButton)) then
        self:remove()
        self:playNote(2)
        local currNote = pd.sound.fileplayer.new("Sounds/bad miss")
        currNote:play(1)
        incrementScore(10)
        print("BAD")
        resetStreak()
    end

    if(self.x >= 31 and self.x < 44 and pd.buttonJustPressed(self.whichButton)) then
        self:remove()
        self:playNote(2)
        incrementScore(25)
        print("OKAY")
    end
    if(self.x <= 70 and self.x > 57 and pd.buttonJustPressed(self.whichButton)) then
        self:remove()
        self:playNote(2)
        incrementScore(25)
        print("OKAY")
    end
end

-- 1 = okay, 2 = good, 3 = perfect
function Note:playNote(noteQuality)
    local currNote
    if(noteQuality == 1) then
        -- play a random note not from this seq
        local whichNote = seqMap[self.whichSeq] + seqCounter + 4
        if whichNote > 16 then
            whichNote = 16 % (seqCounter + 1)
        end
        print("incorrect note: " .. whichNote)
        if whichNote <= 0 then
            whichNote = 1
        end
        currNote = pd.sound.fileplayer.new(notes[whichNote])
        currNote:play(1)
    end
    if(noteQuality == 2) then
        -- play the note from the seq (maybe change the pitch?)
        local whichNote = seqMap[self.whichSeq] + seqCounter
        print(whichNote)
        currNote = pd.sound.fileplayer.new(notes[whichNote])
        currNote:play(1)
    end
    if(noteQuality == 3) then
        currNote = pd.sound.fileplayer.new(notes[8])
        currNote:play(1)
    end
    seqCounter += 1
    if seqCounter >= 4 then
        seqCounter = 0
    end
end

function Note:collisionResponse()
    return "overlap"
end
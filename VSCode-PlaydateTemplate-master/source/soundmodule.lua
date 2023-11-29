local gfx <const> = playdate.graphics
local snd <const> = playdate.sound

class('SoundModule').extends(gfx.sprite)

-- sound testing
--snd.channel.new()
-- pd.sound.channel.setVolume(0.5)
-- playNote format
--   pitch: Hertz values. 261.63 = C4, can also use string for Db3 (D flat 3)
--   volume: 0 to 1
--   length: in seconds if omitted, note will play until you call noteOff
--   when: seconds since the sound engine started, defaults to current time

-- pd.sound.synth:playMIDINote(C4, 1)

-- Synths only have a buffer of one note event, need to createa a sequence instead
--  to play over a period of time
-- pd.sound.synth:setWaveform(pd.sound.kWaveSine)
-- pd.sound.channel:addsource()
-- pd.sound.channel:addeffect()
-- pd.sound.getCurrentTime()
-- pd.sound.synth:playMIDINote(C4, 1)

function SoundModule:init()
    SoundModule.super.init(self)
    self.instrumentList = {}
end

function SoundModule:newsynth()
    local s = snd.synth.new(snd.kWaveSawtooth)
    s:setVolume(0.2)
    s:setAttack(0)
    s:setDecay(0.15)
    s:setSustain(0.2)
    s:setRelease(0)

    self.instrumentList.add(s)
    return s
end

function SoundModule:playSound()
    print(self.instrumentList.length())
end


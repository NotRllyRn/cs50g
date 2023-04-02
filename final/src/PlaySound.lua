return function(sound)
    if sound:isPlaying() then
        sound:stop()
    end
    sound:play()
end
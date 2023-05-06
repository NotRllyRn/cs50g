# Cat Cafe Haven

Lotus approved.

## Main menu

The first thing I started to work on was the menu state. I wanted this to be visually appealing and easy to use in a multitude of ways. The menu should show the title of the game obviously, and what you need to press. I decided to go with 3 simple buttons. Play, Quit, and Credits. You can use your mouse to select the buttons and there is an arrow showing you what you are hovering over. You could also use your keyboard arrows or 'a', 'd' keys to move the pointer left and right. This allows for multiple different types of inputs in the main menu. This took a lot of work with 'GUI' elements. I had to make Backdrops, Text, TextButtons, and Selection elements. 

For the visual appeal, I decided to take a cute cat pack that had donut tiles in it and have them slide across the screen in some way. I wanted the game to have a cute asthetic so I choose a pink background. I coded it so that the donuts are moved from the top left to the bottom right. I coded it so that you could adjust the speed at which they move. The cool thing is that this doesn't lag the game over time. I am not creating any new objects. When the code detects that the donut is off the screen, it will actually move it back to the top left and it will start the loop over. This is very visually appealing and is very cute which is the theme that I was going for.

## Character Selection

This was around the time where I started to implement a character that the player will control. I had no way of testing the character since I only had a Main Menu, so I decided to make a character selection State so that I could test out the character animations. I think this adds interaction with the player and allows more control! There was 10 characters in the pack and I used them all.

Most of the UI elements were just reused from when I made them in the Main Menu. I think it is cool that I made the character animate and walk while you picking the character. Again, you can use your mouse or your keyboard to slide through the characters. One cool thing that I was able to do was keep the donuts in the same places and have them in the same places from the Main Menu. I did this by passing the donuts table through to the Character Selection State. I have a method that updates the donuts from the Main Menu state so I was able to just write 1 line to reuse that bit of code on the states that needed it!

## Credits Screen

At this point in the project, I have started to use a lot of assets and tools from people who have kindly given me the right to use it in my game from Itch.io. I wanted to give credit where it was due and it was starting to get hard to manage all the assets I started to use. The way that implemented the Credits Screen is pretty nice and ergonomic for me to add more credits. I wanted it to be like this so that later, when I need to add more, I can easily and quickly do it. 

I created a table in the initilize function that had all the messages in the order I wanted them to be. Each message was actually a table with 1 string and a font. I wanted some messages to have bigger or smaller text. I then just have a for loop go through all the tables and creates the UI elements for me without me having to define where the x, y, width or height of the ui elements be. To make the text scroll up, I just add to y every update function ran. This makes it super easy for me to modify, add and remove text without having to update the rest of the text and their positions. When the last piece of text reaches the middle of the screen, the code automatically exits out of the state and goes into the Main Menu state.

## Play state

-- TODO: add more documentation

## Credits
- https://luizmelo.itch.io/pet-cat-pack
- https://statoasty.itch.io/ui-assets-pack-2
- https://thorbjorn.itch.io/tiled
- https://gatdesucre.itch.io/sugarland-tileset
- https://almostapixel.itch.io/small-burg-village-pack
- https://tallbeard.itch.io/music-loop-bundle
- https://joshuuu.itch.io/short-loopable-background-music
- https://souptonic.itch.io/souptonic-sfx-pack-1-ui-sounds
- More in the Credit Menu
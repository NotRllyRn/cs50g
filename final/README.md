# **Cat Cafe Haven**

## **Complexity and Destinctiveness**

This is to explain why my game meets the requirements for complexity and distinctiveness. This game has a lot of features and makes sure that the player feels very involved and can see what is going on. I worked hard to make the ui elements so that the player can see things and have a visual aid and visual aspect in the game. This makes the game more interactive as the things around your screen are changing as your do certain actions. This makes it more engaging for players to play. The character has many ways of moving including strafing which means moving at 45 degree angles when pressing 2 keys. I think that the ui elements are very well made and work very well for me to put them in any combination to make almost anything I wanted to for ui elements.

The cats are also very complex and have a lot of features. Each cat has up to 10 different states that it could be in and those states depend on the statistics of the cat. Each cat has statistics which determine it's behavior. Like if a cat is tired, it will most likely go to sleep and have a lower chance of running around. I also made sure that the cats perform certain actions so that the player can see them and react accordingly. The player involvement is very high as you have to do a lot to win the game and even during the starting of the game, you can select your own character giving the player more control and lots of customization.

---

Lotus approved.

## **Main menu**

The first thing I started to work on was the menu state. I wanted this to be visually appealing and easy to use in a multitude of ways. The menu should show the title of the game obviously, and what you need to press. I decided to go with 3 simple buttons. Play, Quit, and Credits. You can use your mouse to select the buttons and there is an arrow showing you what you are hovering over. You could also use your keyboard arrows or 'a', 'd' keys to move the pointer left and right. This allows for multiple different types of inputs in the main menu. This took a lot of work with 'GUI' elements. I had to make Backdrops, Text, TextButtons, and Selection elements. 

For the visual appeal, I decided to take a cute cat pack that had donut tiles in it and have them slide across the screen in some way. I wanted the game to have a cute asthetic so I choose a pink background. I coded it so that the donuts are moved from the top left to the bottom right. I coded it so that you could adjust the speed at which they move. The cool thing is that this doesn't lag the game over time. I am not creating any new objects. When the code detects that the donut is off the screen, it will actually move it back to the top left and it will start the loop over. This is very visually appealing and is very cute which is the theme that I was going for.

Since the background had donuts and there are other states with the same type of background donuts, I thought it would be cool if the same donuts left off where they were in the last state. For this I made it so that the definition variable in the init function of each state to take the donuts and store it into it's own variable. This way I can reuse the table of donuts and have it seemlessly switch states without it looking weird. I thought this was very cool and made the game look professional.

## **Character Selection**

This was around the time where I started to implement a character that the player will control. I had no way of testing the character since I only had a Main Menu, so I decided to make a character selection State so that I could test out the character animations. I think this adds interaction with the player and allows more control! There was 10 characters in the pack and I used them all.

Most of the UI elements were just reused from when I made them in the Main Menu. I think it is cool that I made the character animate and walk while you picking the character. Again, you can use your mouse or your keyboard to slide through the characters. One cool thing that I was able to do was keep the donuts in the same places and have them in the same places from the Main Menu. I did this by passing the donuts table through to the Character Selection State. I have a method that updates the donuts from the Main Menu state so I was able to just write 1 line to reuse that bit of code on the states that needed it!

This was around the point when I added animations between states so that it looks more polished. I went with a simple fade in white and fade out white animation for switching states. This works very well and was inspired by the cs50g games that have them.

## **Credits Screen**

At this point in the project, I have started to use a lot of assets and tools from people who have kindly given me the right to use it in my game from Itch.io. I wanted to give credit where it was due and it was starting to get hard to manage all the assets I started to use. The way that implemented the Credits Screen is pretty nice and ergonomic for me to add more credits. I wanted it to be like this so that later, when I need to add more, I can easily and quickly do it. 

I created a table in the initilize function that had all the messages in the order I wanted them to be. Each message was actually a table with 1 string and a font. I wanted some messages to have bigger or smaller text. I then just have a for loop go through all the tables and creates the UI elements for me without me having to define where the x, y, width or height of the ui elements be. To make the text scroll up, I just add to y every update function ran. This makes it super easy for me to modify, add and remove text without having to update the rest of the text and their positions. When the last piece of text reaches the middle of the screen, the code automatically exits out of the state and goes into the Main Menu state.

## **Play state**

---

### **Character**

The first thing I was able to implement was the character walking, running and idle states. This took a few tries but I got everything including the animations working! I took inspiration and from the cs50g zelda character handling but I changed a few things to my liking.

When I made an early build of this game to give to my friends to test, they were dissapointed there was no strafing in the game, meaning going at an angle. I made an excuse saying that I don't want to implement it or it was too hard, or that I did not have the animations to look like you're going at an angle. Later, when I was playing stardew valley, I saw how the characters could strafe but the game did not have any strafing animations. It simply used the left and right animations. They gave me inspiration and I coded strafing into the game!

The strafing took a while to implement because I had many bugs doing it. I would have a weird glitch on collision of objects in the room where it would teleport me to the other side of the object. To fix this, I made a check that said if the teleporting teleports the player more than 75% of the width of the object, then It won't teleport it. This is a hacky fix but it worked! The bug was most likely due the the collision detection of the object. I also made some checks to see which ways the player was walking and skipped over collision checking of certain parts so that I wouldn't be teleport out of the map if I ran into a wall.

### **Level floor and walls**

I decided to have a static camera that stays in the middle of the screen and over looks the entire level. I also decided that the level have a predetermined size. I did that so that collision detection would be easier for the walls, and so that the characters does not move by tile lengths and instead can be inbetween tiles. The first thing I did was program in the loop that creates the tiles of the level, then in that loop, I created condition checks to create the walls on the top, left and right edges of the tiles. This worked very well and looked good. I thought that the bottom wall cutting off looked off. When I asked a friend what they thought they said it looked fine and natural. 

The first object I made was the plants in the 4 corners of the room. I created an object class and then created object definitions for referencing which tile IDs that created the object. Most of my objects were more than 1 tile so I had to create a system that would render the object correctly but also have the correction collisions of the full rendered object. Luckily, my objects were always rectangles or squares so I did not have to have a weird collision system, "L" shaped objects for example.

The rendering system was made by having a x y table that references the tile IDs to render each part. This worked very well. The collision was simple enough by multiplying the tile size by the number of rows in each direction. I tested this by just putting 4 unique pots (randomly) in each corner of the room. I thought it looked nice and kept it.

The fountain was a little bit harder because it had an animation. I had to add an animation option inside my object class which allowed for me to define which tiles were animations in which order and what x y places. This was a little bit wonky but it worked in the end. All I need to do is tell the object wether the object will have animations or not. This worked well and I was able to add animations to the fountain. The fridge was very similar to the bush since it is the same size, so implementation was fine.

I had to create another UI element for this part because for later, I will have to have a sort of storage of water and food for the cats. I didn't feel like a backpack system was needed and instead opted for 2 bars on the right side of your screen. One would be for food and the other for water. It would just show how much food and water you had. This is also how I gave functionality to the fountain and fridge. When you touched the fridge or fountain, it will refill your corresponding bar. A cool thing I added was if a cat ran into it, it would actually "eat" or "drink" and fix its own bar.

I could then generate the cats and I made an algorithm that would check where the cats are and if they are colliding with any objects it would move the cat to a new position. This will randomly generate any where from 4-6 cats per game.

### Cats

The cats are a big part of this game so I had to make sure they had a lot of states and functionality / things they can do. The first thing I did was try to make the idle and walk state working with animations. After this, I got the idea to add more states like sleeping, laying, itching and more stuff like that. The animation pack that I used for the cats had these extra animations so I decided to use them.

I first imported all the animations and sorted them by each cat because there were 7 cats and each one had around 10 sets of animations for certain actions. This made it simple to code a random cat type when you play the game. After I got the basic states working (idle, walk). I thought it would be a great idea if the cats had statistics and that would effect their behavior. 

I decided to have Hunger, Thirst, Happiness, Energy, Zoomies and Affection. Hunger, thirst, and energy is self explanitory, aswell as happiness. After that, I made an update function on the main entity class of the cat that would update on every state. It just checks how hungry or thirsty the cat is and updates the happiness meter accordingly. The hunger and thirst bar naturally go down after time. Zoomies is the only stat that never changes. It effects how likely a cat is to run around instead of doing other states like walking and laying. Affection effects how likely a cat will meow at you. Meowing is useful for if you want the cat to stay longer with you instead of running around.

Then in certain states like running and walking, I decreased the energy bar as the cat uses up energy going around. That does mean that there are states where the energy goes up like when the cat is sleeping or laying. Since I wanted the statistics to really determine how the cat behaves, I made it so that the cat itches itself when it is thirsty and lick itself when its hungry. These are the only visual indicators for the cat's statistics.

I wanted some sort of reaction from the cats when you interacted with them, for this, I made a table of default cat replies depending on wheter or not they liked or didn't like something. Then when ever the user would interact with the cat, It would look up in the table for a random reply and replace the %s with the cat's name and it would look like the cat was replying to your action. Replying as in a description. This way, you would need to read them to make sure you're not overpetting the cat which can happen, and the cat would get annoyed and unhappy fast.

### Cat information menu

To win the game, you need to make all the cats happy. Right now there is nothing but the cats and you running around. I had to create some sort of menu or way for you to interact with a cat. I had the idea for you to go up to a cat and press "e" to open a menu for you to interact with the cat.

I took a keyboard tileset and rendered the keyboard letter "E" above a cat once you got near it. When you pressed "E" on your keyboard, it would open a side menu either on the left or right depending on where you are in the map and this would have the cat's name, statistics, and buttons to interact with the cat. The menu took a while to get right because I had to make the bars to show how much is filled instead of just numbers. I think that the visual aspect is nice. 

I decided to go with 3 buttons. "Pet", "Feed", "Water the cat". The last one is suppose to be funny because I didn't know a good way to say "Give water to the cat" in one word. Maybe quench would work. Anyways, the pet button increases the cat's happiness and also increases affection statistic so the cat is more likely to stay around you. I realized that the main way you win this game is to get the cat's happiness above 90% and the pet directly effects that statistic, so I added a pet cooldown for every cat depending on their affection statistic.

To show the player how hungry or thirsty the cat is, I reused the bars I used to make show the player how much food and water they have to show the player what the cat's statisitcs are. The feed button will take away from your Food bar and lessen the "hunger" statistic on the cat. Same thing for the "water" button but for the thirst and water bars. I added labels for each bar to not confuse short abbriviations for the names next to the bars.

The hardest part was just trying to get all the ui elements to look nice with each other, I had to position the cats



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
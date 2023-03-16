--[[
    GD50
    Angry Birds

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Level = Class{}

function Level:init()
    
    -- create a new "world" (where physics take place), with no x gravity
    -- and 30 units of Y gravity (for downward force)
    self.world = love.physics.newWorld(0, 300)

    -- bodies we will destroy after the world update cycle; destroying these in the
    -- actual collision callbacks can cause stack overflow and other errors
    self.destroyedBodies = {}

    -- define collision callbacks for our world; the World object expects four,
    -- one for different stages of any given collision
    function beginContact(a, b, coll)
        local types = {}
        types[a:getUserData()] = true
        types[b:getUserData()] = true

        -- if we collided between both the player and an obstacle...
        if types['Obstacle'] and types['Player'] then

            -- grab the body that belongs to the player
            local playerFixture = a:getUserData() == 'Player' and a or b
            local obstacleFixture = a:getUserData() == 'Obstacle' and a or b
            
            -- destroy the obstacle if player's combined X/Y velocity is high enough
            local velX, velY = playerFixture:getBody():getLinearVelocity()
            local sumVel = math.abs(velX) + math.abs(velY)

            if sumVel > 20 then
                table.insert(self.destroyedBodies, obstacleFixture:getBody())
            end
            for k, alien in pairs(self.launchMarker.aliens) do
                alien.hit = true
            end
        end

        -- if we collided between an obstacle and an alien, as by debris falling...
        if types['Obstacle'] and types['Alien'] then

            -- grab the body that belongs to the player
            local obstacleFixture = a:getUserData() == 'Obstacle' and a or b
            local alienFixture = a:getUserData() == 'Alien' and a or b

            -- destroy the alien if falling debris is falling fast enough
            local velX, velY = obstacleFixture:getBody():getLinearVelocity()
            local sumVel = math.abs(velX) + math.abs(velY)

            if sumVel > 20 then
                table.insert(self.destroyedBodies, alienFixture:getBody())
            end
        end

        -- if we collided between the player and the alien...
        if types['Player'] and types['Alien'] then

            -- grab the bodies that belong to the player and alien
            local playerFixture = a:getUserData() == 'Player' and a or b
            local alienFixture = a:getUserData() == 'Alien' and a or b

            -- destroy the alien if player is traveling fast enough
            local velX, velY = playerFixture:getBody():getLinearVelocity()
            local sumVel = math.abs(velX) + math.abs(velY)

            if sumVel > 20 then
                table.insert(self.destroyedBodies, alienFixture:getBody())
            end
            for k, alien in pairs(self.launchMarker.aliens) do
                alien.hit = true
            end
        end

        -- if we hit the ground, play a bounce sound
        if types['Player'] and types['Ground'] then
            gSounds['bounce']:stop()
            gSounds['bounce']:play()
        end
    end

    -- the remaining three functions here are sample definitions, but we are not
    -- implementing any functionality with them in this demo; use-case specific
    -- http://www.iforce2d.net/b2dtut/collision-anatomy
    function endContact(a, b, coll)
        
    end

    function preSolve(a, b, coll)

    end

    function postSolve(a, b, coll, normalImpulse, tangentImpulse)

    end

    -- register just-defined functions as collision callbacks for world
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    -- shows alien before being launched and its trajectory arrow
    self.launchMarker = AlienLaunchMarker(self.world)

    -- aliens in our scene
    self.aliens = {}

    -- obstacles guarding aliens that we can destroy
    self.obstacles = {}

    -- simple edge shape to represent collision for ground
    self.edgeShape = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH * 3, 0)

    -- spawn an alien to try and destroy
    table.insert(self.aliens, Alien(self.world, 'square', VIRTUAL_WIDTH - 80, VIRTUAL_HEIGHT - TILE_SIZE - ALIEN_SIZE / 2, 'Alien'))

    -- spawn a few obstacles
    table.insert(self.obstacles, Obstacle(self.world, 'vertical',
        VIRTUAL_WIDTH - 120, VIRTUAL_HEIGHT - 35 - 110 / 2))
    table.insert(self.obstacles, Obstacle(self.world, 'vertical',
        VIRTUAL_WIDTH - 35, VIRTUAL_HEIGHT - 35 - 110 / 2))
    table.insert(self.obstacles, Obstacle(self.world, 'horizontal',
        VIRTUAL_WIDTH - 80, VIRTUAL_HEIGHT - 35 - 110 - 35 / 2))

    -- ground data
    self.groundBody = love.physics.newBody(self.world, -VIRTUAL_WIDTH, VIRTUAL_HEIGHT - 35, 'static')
    self.groundFixture = love.physics.newFixture(self.groundBody, self.edgeShape)
    self.groundFixture:setFriction(0.5)
    self.groundFixture:setUserData('Ground')

    -- background graphics
    self.background = Background()
end

function Level:update(dt)
    -- update launch marker, which shows trajectory
    self.launchMarker:update(dt)

    -- Box2D world update code; resolves collisions and processes callbacks
    self.world:update(dt)

    -- destroy all bodies we calculated to destroy during the update call
    for k, body in pairs(self.destroyedBodies) do
        if not body:isDestroyed() then 
            body:destroy()
        end
    end

    -- reset destroyed bodies to empty table for next update phase
    self.destroyedBodies = {}

    -- remove all destroyed obstacles from level
    for i = #self.obstacles, 1, -1 do
        if self.obstacles[i].body:isDestroyed() then
            table.remove(self.obstacles, i)

            -- play random wood sound effect
            local soundNum = math.random(5)
            gSounds['break' .. tostring(soundNum)]:stop()
            gSounds['break' .. tostring(soundNum)]:play()
        end
    end

    -- remove all destroyed aliens from level
    for i = #self.aliens, 1, -1 do
        if self.aliens[i].body:isDestroyed() then
            table.remove(self.aliens, i)
            gSounds['kill']:stop()
            gSounds['kill']:play()
        end
    end

    -- replace launch marker if original alien stopped moving
    if self.launchMarker.launched then
        local all_stopped = true
        
        for k, alien in pairs(self.launchMarker.aliens) do
            local xPos, yPos = alien.body:getPosition()
            local xVel, yVel = alien.body:getLinearVelocity()

            if xPos >= 0 and (math.abs(xVel) + math.abs(yVel) >= 1.5) then
                all_stopped = false
            end
        end

        -- if we fired our alien to the left or it's almost done rolling, respawn
        if all_stopped then
            for k, alien in pairs(self.launchMarker.aliens) do
                alien.body:destroy()
            end
            self.launchMarker = AlienLaunchMarker(self.world)

            -- re-initialize level if we have no more aliens
            if #self.aliens == 0 then
                gStateMachine:change('start')
            end
        end
    end
end

function Level:copyAlien(alien, x, y)
    local xPos, yPos = alien.body:getPosition()
    if x and y then
        xPos = x
        yPos = y
    end
    local xVel, yVel = alien.body:getLinearVelocity()
    local new_alien = Alien(self.world, alien.type, xPos, yPos, alien.fixture:getUserData())
    new_alien.body:setLinearVelocity(xVel, yVel)
    new_alien.fixture:setRestitution(0.4)
    new_alien.body:setAngularDamping(1)

    new_alien.hit = true

    table.insert(self.launchMarker.aliens, new_alien)
end

function Level:spawn3MoreAlien()
    local launchMarker = self.launchMarker

    local main_alien = #launchMarker.aliens == 1 and launchMarker.aliens[1] and
        not launchMarker.aliens[1].hit and launchMarker.aliens[1] or nil

    if launchMarker.launched and main_alien then
        local xPos, yPos = main_alien.body:getPosition()
    
        -- create 2 more aliens 1 above and 1 below the main alien
        self:copyAlien(main_alien, xPos, yPos - 50)
        self:copyAlien(main_alien, xPos, yPos + 50)
    end
end

function Level:render()
    
    -- render ground tiles across full scrollable width of the screen
    for x = -VIRTUAL_WIDTH, VIRTUAL_WIDTH * 2, 35 do
        love.graphics.draw(gTextures['tiles'], gFrames['tiles'][12], x, VIRTUAL_HEIGHT - 35)
    end

    self.launchMarker:render()

    for k, alien in pairs(self.aliens) do
        alien:render()
    end

    for k, obstacle in pairs(self.obstacles) do
        obstacle:render()
    end

    -- render instruction text if we haven't launched bird
    if not self.launchMarker.launched then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf('Click and drag circular alien to shoot!',
            0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    -- render victory text if all aliens are dead
    if #self.aliens == 0 then
        love.graphics.setFont(gFonts['huge'])
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf('VICTORY', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end
end
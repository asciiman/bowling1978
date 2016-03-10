# bowling1978

## Background
Demo ruby on rails app

I was given this app as a code test assignment for a company I am applying for in Munich.

The app comes complete with validations and unit tests.  I had originally tried dividing out the models into Games, Players, Frames, and Throws.  But since all those objects were heavily dependant on each other, I made the choice to simplify the architecture into simply Games and Throws.  For the most part this worked much better than the original plan.

There are several things that would improve this app:
- Seperate the sensor from the screen
- Use sockets to push updates to the screen
- Add player names

One of the biggest places that could be improved is how the DB is being called.  There isn't any reason why the DB could just be queried a single time per screen load and then parsed.  It's a small enough app that it doesn't make any real different at the moment.  But if we needed performace improvements, this would be the place to focus on.

## Assigned instructions

Write a Ruby on Rails API that takes score of a bowling game.

You have the freedom to define the architecture of the API and how its endpoints will look.

Main Requirements:

The API should be written using Ruby on Rails. In addition, it should provide the following:

● A way to start a new bowling game;

● A way to input the number of pins knocked down by each ball;

● A way to output the current game score (score for each frame and total score).

Imagine that this API will be used by a bowling house. On the screen the user starts the game, then after each throw the machine, with a sensor, counts how many pins were dropped and calls the API sending this information. In the meantime the screen is constantly (for example: every 2 seconds) asking the API for the current game status and displays it.

Logic details

● Bowling is played by throwing a ball down a narrow alley toward ten wooden pins. The objective is to knock down as many pins as possible per throw.

● The game is played in ten frames. At the beginning of each frame, all ten pins are set up. The player then gets two tries to knock them all down.

● If the player knocks all the pins down on the first try, it is called a "strike,“ and the frame ends.

● If the player fails to knock down all the pins with his first ball, but succeeds with the second ball, it is called a "spare“.

● After the second ball of the frame, the frame ends even if there are still pins standing.

● A strike frame is scored by adding ten, plus the number of pins knocked down by the next two balls, to the score of the previous frame.

● A spare frame is scored by adding ten, plus the number of pins knocked down by the next ball, to the score of the previous frame.

● Otherwise, a frame is scored by adding the number of pins knocked down by the two balls in the frame to the score of the previous frame.

● If a strike is thrown in the tenth frame, then the player may throw two more balls to complete the score of the strike.

● Likewise, if a spare is thrown in the tenth frame, the player may throw one more ball to complete the score of the spare.

● Thus the tenth frame may have three balls instead of two.

For background information, please see http://en.wikipedia.org/wiki/Ten-pin_bowling

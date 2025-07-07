# About this prototype
This prototype is meant to simulate the character object and its physics interaction.

A state machine is implemented to organise different states of the character
behavior, which includes:

1. Idle

2. Jump

3. Fall

4. Run

5. Attack

6. Dash

7. Double jump

8. Hurt

9. Death 

# Known issues
1. The current implementation of the sound effect is not uniform in terms of method. The jumping and
dashing sound is played with a callback of a playsound function in player node, while the attacking
sound is played by using the animation player. The reason is that the jumping sound need to be overlapped
if pressed in quick succession while the attack sound should be played with a slight delay to fit the
animation. A better solution is to be found.


# Future todo lists
1. Add a fade to black upon character death
2. working on a functional enemy

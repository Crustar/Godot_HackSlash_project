# About this prototype
This prototype is meant to simulate the character object and its physics interaction.

A state machine is implemented to organise different states of the character
behavior, which includes:

1. Idle

2. Jump

3. Fall

4. Run

5. Attack (TODO)

6. Dodge (TODO)

7. Double jump (TODO)

8. Hurt (TODO)

9. Death (TODO)

# Known issues
NONE

# Future todo lists
1. Replace the current state machine trigger system from "Checking every tick"
to "Triggered by signal event" in order to improve performance.

2. Add a "PlayerAnimationPlayer" class for better IDE compatibility

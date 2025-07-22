# About this project
This is a work-in-progress Hack-n-Slash game developpement project. It serves as an opportinity to learn coding as well as project management.

The game is being made using the game engine Godot (GDScript). The goal is to complete a game combining the platformer's moveability and fighting game's combo mechanic to create a smooth hack-n-slash game experience with skilling ceiling.

# Current progress
<img src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExNjZqcjM2bTNjcjA0N3FyeXYxNHhvN3drdGRmMGt3dThvNjFkNzdieCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/cgMVWltzyvk3WuC9YH/giphy.gif" width="300">

Basic character control logic has been implemented. Player can control the character to move, jump, dash as well as performing a 3-steps attack. Player can be hurt and die.

A basic enemy type (mushroom) has been implemented. It will move around and hurt the character if it touches the latter's hurtbox. It currently has no tracking mechanic that allows it to chase the character.

A mock scene has been implemented. It contains the fore-mentioned player and enemy.

# Future plan
1. Design and create a level with spawning enemies (game loop)
2. Implement a new attacky style allowing the character to perform air combo.

# Known issues
1. Currently, the camera's limit is set manually, if multiple scenes(levels) are to be created, its parameter should be set automatically by the script
2. When the player attack in the air and then cancel with dash in the opposite direction, the character sprite will not flip to the right facing as well as the dashing speed

# Lesson learned
1. Use state machine logic to keep the scalability of the code, multiple cascades of "if" statement will quickly create confusion going into the developpement process.
2. Pre-plan the class structure. Coding efficiency can be drastically improved if proper custom class are thought before-hand in order to not only reduce duplicant code but also allow dev to better understand why an object is coded in such a way.
3. "Call down, signal up", having a clear general logic when it comes how nodes communicate with each other will drastically increase extensibility and maintainability.

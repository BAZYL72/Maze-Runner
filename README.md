Maze Runner – Multi-Level Console Game (x86 Assembly)
Maze Runner is a retro-style, text-based maze game built in 80386 Intel x86 (32-bit) Assembly Language using the Irvine32 library.

The player must navigate through three progressively challenging mazes, avoid walls, and reach the exit to advance.

Game Overview
You control a player inside a maze and must reach the exit without walking into walls.

Symbols used in the game:

Symbol	Meaning
@	Player
E	Exit
█ or `	`
Space	Walkable path
The game starts with a title screen, followed by an instruction screen, and then launches into Level 1.
Completing a level automatically loads the next maze.

Levels
The game contains three handcrafted maze levels, each more complex than the last:

Level	Description
Level 1	Small maze to introduce movement and collision
Level 2	Medium maze with tighter paths
Level 3	Large, dense maze requiring careful navigation
The player’s position and the exit location are tracked internally and updated in real time.

Controls
You can move the player using either:

W A S D
Arrow Keys
Key	Action
W / ↑	Move Up
S / ↓	Move Down
A / ←	Move Left
D / →	Move Right
Movement is blocked if a wall is in the way.

How It Works
This game uses:

2D character arrays stored in memory to represent each maze
Direct console cursor positioning for rendering
Keyboard input polling via Irvine32
Collision detection by checking map values before moving
Level switching when the player reaches E
Each level has its own maze layout and starting position.

Built With
Intel x86 Assembly (80386, 32-bit)
MASM
Irvine32 Library
Visual Studio
How to Run
Install Visual Studio
Install and configure Irvine32 for MASM
Open Maze_Runner_MultiLevel.sln
Build in Win32 Debug mode
Run Maze_Runner_MultiLevel.exe
Project Structure
Maze_Runner_MultiLevel/
├── main.asm
├── Maze_Runner_MultiLevel.sln
├── Maze_Runner_MultiLevel.vcxproj
└── Maze_Runner_MultiLevel.vcxproj.filters
What This Project Demonstrates
Assembly-level game loops
Real-time keyboard input
Map-based collision detection
Multi-level game state management
Console UI rendering
Low-level memory handling
Goal
Reach the E (Exit) in all three levels to win the game.

License
This project is licensed under the MIT License.

Author
Arsalan Tahir , Usayd Arsalan , Bazyl Sheikh

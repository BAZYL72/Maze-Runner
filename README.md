## Maze Runner – Multi-Level Console Game (x86 Assembly)

Maze Runner is a text-based maze game built in 80386 Intel x86 (32-bit) Assembly Language using the Irvine32 library.

The player navigates through three progressively difficult mazes, avoids walls, and reaches the exit to advance.

---

## Game Overview

You control a player inside a maze and must reach the exit without hitting walls.

### Symbols Used

| Symbol         | Meaning       |
| -------------- | ------------- |
| `@`            | Player        |
| `E`            | Exit          |
| `█` or `` ` `` | Wall          |
| Space          | Walkable path |

The game starts with:

* Title screen
* Instructions screen
* Level 1

Each completed level automatically loads the next maze.

---

## Levels

| Level   | Description                                   |
| ------- | --------------------------------------------- |
| Level 1 | Small maze introducing movement and collision |
| Level 2 | Medium maze with tighter paths                |
| Level 3 | Large dense maze requiring precise navigation |

Each level includes:

* Unique maze layout
* Defined start position
* Exit tracking

---

## Controls

| Key   | Action     |
| ----- | ---------- |
| W / ↑ | Move Up    |
| S / ↓ | Move Down  |
| A / ← | Move Left  |
| D / → | Move Right |

Movement is blocked if a wall is detected.

---

## How It Works

* 2D character arrays represent each maze
* Console cursor positioning is used for rendering
* Keyboard input is handled via Irvine32
* Collision detection checks map values before movement
* Level transitions trigger when the player reaches `E`

---

## Core Mechanics

* Real-time input handling
* Grid-based movement system
* State-based level progression
* Console rendering loop
* Memory-based maze representation

---

## Built With

* Intel x86 Assembly (80386, 32-bit)
* MASM
* Irvine32 Library
* Visual Studio

---

## How to Run

1. Install Visual Studio
2. Install and configure Irvine32 for MASM
3. Open the solution file:

   ```
   Maze_Runner_MultiLevel.sln
   ```
4. Build in Win32 Debug mode
5. Run:

   ```
   Maze_Runner_MultiLevel.exe
   ```

---

## Project Structure

```
Maze_Runner_MultiLevel/
├── main.asm
├── Maze_Runner_MultiLevel.sln
├── Maze_Runner_MultiLevel.vcxproj
└── Maze_Runner_MultiLevel.vcxproj.filters
```

---

## What This Project Demonstrates

* Assembly-level game loop design
* Real-time keyboard input handling
* Collision detection logic
* Multi-level game state management
* Console-based rendering system
* Low-level memory handling

---

## Goal

Reach `E` (Exit) in all three levels to complete the game.

---

## License

MIT License

---

## Authors

* Arsalan Tahir
* Usayd Arsalan
* Bazyl Sheikh

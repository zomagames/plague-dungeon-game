# Development Guide

## Setting Up Your Development Environment

### 1. Install Godot 4.0+
- Download: https://godotengine.org/download
- Extract to a folder
- Run godotengine executable

### 2. Clone the Repository
```bash
git clone https://github.com/zomagames/plague-dungeon-game.git
cd plague-dungeon-game
```

### 3. Open in Godot
- File → Open Project → Select `plague-dungeon-game` folder
- Click "Open" to import project

### 4. Run the Game
- Press F5 or click Play button in top-right
- Game window opens at 1280x720
- Press ESC to stop

---

## Project Structure Deep Dive

### Scenes (res://scenes/)
```
main.tscn          Main game scene (combines all systems)
player.tscn        Player character (controllable, takes damage)
enemy.tscn         Enemy AI (chases and damages player)
projectile.tscn    Projectile (fired by player weapon)
ui/
  pause_menu.tscn  Pause menu UI
  upgrade_screen.tscn  Upgrade selection screen
```

### Scripts (res://scripts/)
```
game_manager.gd    Game state, scoring, wave progression
player.gd          Player movement, health, input handling
enemy.gd           Enemy AI, collision, death
weapon.gd          Projectile firing system
projectile.gd      Projectile movement and collision
spawner.gd         Enemy spawning and difficulty scaling
ui.gd              UI updates (score, wave display)
```

### Assets (res://assets/)
```
sprites/           Your 2D sprite files
sounds/            Audio effects and music
fonts/             Custom fonts for UI
themes/            UI themes and styles
```

---

## Game Loop Flow

Each Frame (_physics_process delta):
  1. GameManager: Updates time, checks for pause
  2. Player: Gets input, moves, weapon fires
  3. Spawner: Spawns new enemies if timer ready
  4. Each Enemy: Chases player, moves, checks collision
  5. Each Projectile: Moves, checks collision with enemies
  6. UI: Updates score and wave display

---

## Common Development Tasks

### Adding a New Sprite

1. Place sprite file in `res://assets/sprites/`
2. In scene, select Sprite2D node
3. Inspector → Texture → Select your sprite file
4. Adjust scale and position

### Adding a New Sound

1. Place audio file in `res://assets/sounds/`
2. Create AudioStreamPlayer node
3. Set Stream property to your audio file
4. In script: `$AudioStreamPlayer.play()`

### Creating a New Weapon Type

1. Copy weapon.gd
2. Modify firing pattern in fire_in_all_directions() function
3. Update weapon_type export variable

### Adding a Power-Up

1. Create new scene: `res://scenes/powerup.tscn`
2. Add Area2D with Sprite2D and CollisionShape2D
3. Script: `res://scripts/powerup.gd`
4. Define effect (damage boost, fire rate, heal, etc.)
5. Spawn from enemies when killed

---

## Debugging Tips

### Print Debug Messages
```gdscript
print("[PlayerName] Message here: ", variable)
```
Messages appear in Godot's Output tab.

### Remote Debugger
- Run game (F5)
- Godot → Debugger tab (top)
- Inspect nodes and variables in real-time
- Set breakpoints in code

### Test Scenes Individually
- Right-click scene → Play Scene (F6)
- Useful for testing player or enemy without full game

### Performance Profiling
- Debug → Profile → Monitor
- Watch FPS, memory usage
- Identify bottlenecks

---

## Version Control with Git

### Commit Workflow
```bash
git status
git add .
git commit -m "Add sword weapon type"
git push origin main
```

### Branch for Features
```bash
git checkout -b feature/new-weapon
git commit -m "Implement sword weapon"
git push origin feature/new-weapon
```

---

## Performance Optimization

### Enemy Count
- Use Area2D for collision detection
- Consider object pooling for repeated instances

### Projectile Optimization
- Remove projectiles after lifetime expires
- Use object pooling for high fire rate weapons

### Rendering
- Use 2D physics layer masks for efficient collisions
- Avoid complex transparency effects
- Use texture atlases for sprites

---

## Next Steps

1. Test the base game
2. Add your sprites (see below)
3. Add audio (background music, shooting sounds)
4. Implement upgrade system
5. Polish and test on all platforms

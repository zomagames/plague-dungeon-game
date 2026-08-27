# Plague Dungeon - Vampire Survivors Game

A cross-platform Vampire Survivors-style roguelike game built with Godot Engine.

## 🎮 Features
- Automatic character movement and combat
- Hundreds of enemies with progressive difficulty
- XP and leveling system with weapon upgrades
- Multiple weapon types and power-ups
- High score tracking
- Cross-platform support: Web, PC, Android, Steam, Play Store

## 📋 Requirements
- Godot Engine 4.0+
- Git

## 🚀 Getting Started

### 1. Install Godot
Download from: https://godotengine.org/download

### 2. Clone and Open Project
```bash
git clone https://github.com/zomagames/plague-dungeon-game.git
cd plague-dungeon-game
```
Then open the project folder in Godot Editor.

### 3. Project Structure
```
plague-dungeon-game/
├── scenes/           # Game scenes (Player, Enemies, UI, Main)
├── scripts/          # GDScript code for game logic
├── assets/
│   ├── sprites/      # Your sprite files
│   ├── sounds/       # Audio effects and music
│   ├── fonts/        # Custom fonts for UI
│   └── themes/       # UI themes
├── export/           # Export configurations
└── project.godot     # Project configuration
```

## 🎯 Development Phases

### Phase 1: Foundation
- [ ] Player character with WASD movement
- [ ] Basic enemy spawning
- [ ] Collision detection
- [ ] Simple camera follow

### Phase 2: Combat
- [ ] Player weapons (projectiles)
- [ ] Enemy health and death
- [ ] Score system
- [ ] Wave progression

### Phase 3: Progression
- [ ] XP and leveling
- [ ] Upgrade selection UI
- [ ] Multiple weapon types
- [ ] Difficulty scaling

### Phase 4: Polish
- [ ] Audio (SFX and music)
- [ ] Visual effects (particles, screen shake)
- [ ] UI refinement
- [ ] High score persistence

## 📱 Platform Export

### Web (HTML5)
```bash
# Godot Editor → Project → Export
# Select: Web → Export Project
# Upload HTML/JS files to web server
```

### PC (Windows/Linux)
```bash
# Godot Editor → Project → Export
# Select: Windows Desktop or Linux/X11
```

### Android
```bash
# Setup Android SDK in Godot Project Settings
# Godot Editor → Project → Export
# Select: Android → Export Project
```

### Steam
- Export PC version
- Create Steam app
- Upload via Steamworks
- See: https://docs.godotengine.org/en/stable/tutorials/platform_specifics/exporting_for_steam.html

### Google Play Store
- Export Android APK
- Sign APK with keystore
- Upload to Google Play Console

## 🎨 Adding Your Sprites

1. Place sprite files in `assets/sprites/`
2. Import in Godot (automatic)
3. Reference in scenes: `res://assets/sprites/sprite_name.png`

## 🔧 Development

Run the game:
- Press `F5` in Godot Editor or click Play button
- Game window opens at 1280x720

Edit scenes:
- Double-click `.tscn` files in FileSystem
- Drag nodes, add scripts, configure properties

## 📦 Building for Release

See `export/README.md` for detailed export instructions.

## 📝 License

See LICENSE file.

## 🤝 Contributing

This is your solo project, but feel free to share and collaborate!

---

**Next Step:** Open the project in Godot Editor and start with Phase 1!

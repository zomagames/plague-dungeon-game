# Export Instructions

This directory contains export configurations for deploying Plague Dungeon to multiple platforms.

## Platform Export Guides

### 1. Web (HTML5)
**Best for:** Playing in browser on any device

1. Open Godot Editor
2. Project → Project Settings → Export
3. Click "Add Preset"
4. Select "Web"
5. Configure:
   - Export Path: `export/web/index.html`
   - Runnable: ON
6. Click "Export Project"
7. Upload files to web server or GitHub Pages

**Hosting Options:**
- GitHub Pages (free)
- Netlify (free)
- Itch.io (free, game-focused)

### 2. PC (Windows)
**Best for:** Desktop gaming

1. Project → Project Settings → Export
2. Add Preset: "Windows Desktop"
3. Configure:
   - Export Path: `export/windows/plague_dungeon.exe`
   - Binary Format: 64-bit
4. Export Project
5. Test on Windows machine

**Distribution:**
- Direct download
- Itch.io (free)
- Steam (requires Steamworks setup)

### 3. Android
**Best for:** Mobile gaming

**Prerequisites:**
- Android SDK (installed via Android Studio)
- Java Development Kit (JDK)
- Configure in Godot:
  - Project → Project Settings → Debug → GDScript
  - Set Android SDK Path
  - Set Android NDK Path
  - Set Java SDK Path

**Export Steps:**
1. Project → Project Settings → Export
2. Add Preset: "Android"
3. Configure:
   - Export Path: `export/android/plague_dungeon.apk`
   - Package: `com.zomagames.plaguedungeon`
   - Application: Change Icon (use res://icon.svg)
   - Architectures: arm64-v8a (or universal)
4. Export Project

**Testing:**
```bash
adb install -r export/android/plague_dungeon.apk
```

**Distribution:**
- Google Play Store
- Itch.io
- Direct APK download

### 4. Steam
**Best for:** PC gaming audience

**Prerequisites:**
- Steam developer account ($100 one-time fee)
- Steamworks SDK
- SteamWorks for Godot addon

**Steps:**
1. Export Windows version
2. Create Steamworks app
3. Configure app in Steamworks
4. Upload build via Steamworks
5. Set launch date and pricing
6. Submit for review

**Reference:** https://docs.godotengine.org/en/stable/tutorials/platform_specifics/exporting_for_steam.html

### 5. Google Play Store
**Best for:** Mobile audience

**Prerequisites:**
- Google Play Developer account ($25 one-time fee)
- Google Play signing key

**Steps:**
1. Export Android APK with signing
2. Go to Google Play Console
3. Create new app
4. Fill in store listing details
5. Upload APK
6. Configure pricing and regions
7. Submit for review (2-3 hours)

**Store Details Needed:**
- App name, description
- Screenshots (minimum 2)
- App icon (512x512)
- Feature graphic (1024x500)
- Category and rating

## Quick Reference

| Platform | Export Format | Audience | Effort |
|----------|---------------|----------|--------|
| Web | HTML5 | Browser users | Easy |
| Windows | .exe | PC gamers | Easy |
| Android | .apk | Mobile users | Medium |
| Steam | Windows build | Core gamers | Hard |
| Play Store | .aab | Mobile users | Hard |

## Sign APK for Play Store

```bash
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
  -keystore plague_dungeon.keystore \
  -storepass your_password \
  export/android/plague_dungeon.apk alias_name
```

## Testing Locally Before Export

```bash
cd export/web
python -m http.server 8000
Visit http://localhost:8000

Test native builds:
./export/windows/plague_dungeon.exe
./export/linux/plague_dungeon
```

---

**Next Steps:**
1. Complete game development
2. Test on target platform
3. Optimize if needed
4. Create store pages
5. Deploy!

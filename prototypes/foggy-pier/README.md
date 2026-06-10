# Foggy Pier — cozy-horror movement prototype

A tiny, runnable Godot 4 scaffold: a lantern-lit figure walks an island pier
under drifting fog and a vignetted, moonlit dark. It exists to prove the
toolchain works and to set the *mood* before we build real systems — think the
quiet, uneasy calm of **Dredge** at dusk.

This is a **scaffold**, not a game yet. Everything visual is placeholder
geometry (colored polygons), meant to be swapped for real art later.

## Requirements

- [Godot **4.3** or newer](https://godotengine.org/download) (stable). No C#
  needed — this uses GDScript only.

## How to run it

1. Open Godot. On the Project Manager, click **Import**.
2. Select `prototypes/foggy-pier/project.godot` and click **Import & Edit**.
3. Press **F5** (Run Project), or the ▶ play button, top-right.

## Controls

- **WASD** or **Arrow keys** — walk.
- The camera follows you with a gentle smoothing lag.
- **Esc** quits (Godot default while running from the editor).

## What's in here

```
foggy-pier/
├─ project.godot          # Engine config; main scene + window/rendering setup
├─ icon.svg               # Project icon (placeholder)
├─ scenes/
│  ├─ main.tscn           # The pier: water, deck, planks, posts, fog, player
│  └─ player.tscn         # CharacterBody2D + cloak/head art + lantern light + camera
└─ scripts/
   ├─ player.gd           # Smooth acceleration-based movement; lantern flicker
   └─ fog.gdshader        # Self-contained drifting fog + vignette (no texture needed)
```

## Why it looks the way it does (the cozy-horror knobs)

The atmosphere is driven by a few intentional, tweakable pieces. Select the
node in the editor and edit the values in the **Inspector** to feel them:

- **`Main/Darkness` (CanvasModulate)** — tints the whole world toward a cold,
  moonlit blue so nothing is at full daylight brightness.
- **`Player/Lantern` (PointLight2D)** — the one warm light source, cutting a
  pocket of safety out of the dark. It subtly flickers (see `player.gd`).
- **`FogLayer/Fog` (ColorRect + `fog.gdshader`)** — drifting fog plus an edge
  vignette. Open the Material in the Inspector to tweak `density`,
  `scroll_speed`, `scale`, and `vignette`.

## Obvious next steps (when you're ready)

- Swap placeholder polygons for real pixel art (a tileset for the deck/water,
  an animated sprite for the figure).
- Add a **day/night cycle** that ramps the darkness over time.
- Add the **dread mechanic** — a panic/sanity meter that rises the longer
  you're away from light or out past nightfall.
- Add ambient sound: lapping water, a distant bell, the creak of planks.

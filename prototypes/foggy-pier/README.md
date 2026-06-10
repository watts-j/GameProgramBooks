# Foggy Pier — cozy-horror movement prototype

A tiny, runnable Godot 4 scaffold: a lantern-lit figure walks the wharf of a
fog-bound island — out along a pier over black water and back onto land — under
a vignetted, moonlit dark. It exists to prove the toolchain works and to set the
*mood* before we build real systems — think the quiet, uneasy calm of **Dredge**
at dusk.

It's drawn in a **3/4 perspective** the cheap-but-honest way: an angled
landmass with a visible cliff/side face, a pier that **tapers and foreshortens
as it recedes** into the water (matching the island's projection), an upright
"billboard" figure, and **Y-sorting** so you pass *behind* far mooring posts
and *in front of* near ones. The walkable surface (island + pier) is fenced by
a collision boundary, so **you can't walk off into the water** — you slide
along the edge instead.

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

- **WASD** or **Arrow keys** — walk (movement is screen-aligned: W = up).
- The camera follows you with a gentle smoothing lag.
- Try to walk into the water — the boundary keeps you on the wharf.
- **Esc** quits (Godot default while running from the editor).

## What's in here

```
foggy-pier/
├─ project.godot          # Engine config; main scene + window/rendering setup
├─ icon.svg               # Project icon (placeholder)
├─ scenes/
│  ├─ main.tscn           # Island + wharf: water, land, pier, props, boundary, Y-sort, fog
│  └─ player.tscn         # CharacterBody2D (feet at origin) + cloak/head + lantern + camera
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
- **`Boundary/Edge` (CollisionPolygon2D, *Segments* build mode)** — traces the
  perimeter of the walkable area (pier + island). This is the invisible wall.
  Reshape it if you change the land; the player is confined to its inside.
- **`YSort` (Node2D, *Y Sort Enabled*)** — anything parented here (posts,
  crates, lamp, the player) draws in depth order by its feet. That's what sells
  the 3/4 perspective.

## Obvious next steps (when you're ready)

- Swap placeholder polygons for real pixel art (a tileset for the deck/water,
  an animated sprite for the figure).
- Add a **day/night cycle** that ramps the darkness over time.
- Add the **dread mechanic** — a panic/sanity meter that rises the longer
  you're away from light or out past nightfall.
- Add ambient sound: lapping water, a distant bell, the creak of planks.

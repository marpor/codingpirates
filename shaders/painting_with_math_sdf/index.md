---
title: Shaders Workshop — Painting with Math (SDF Edition)
---
# {{ page.title }}

**Audience:** Ages 13–17 with basic coding experience  
**Tool:** [ShaderToy](https://www.shadertoy.com) (fragment shader only)  
**Goal:** Build up, one concept at a time, from a single circle to an animated, glowing, colorful scene — while learning the math behind it (UVs, Pythagoras, SDFs, mixing, etc.).

---

## Quick Start

1. Open ShaderToy → **New Shader**.
2. You’ll edit the `mainImage` function only.
3. A **fragment shader** runs once **per pixel** to decide that pixel’s color — massively in parallel on the GPU.

> Mental model: “Each pixel asks the shader: *what color should I be?* The shader answers using math.”

---

## Step by Step

1. [Part 0 — Hello, GPU](part00_hello_gpu.md)
1. [Part 1 — Normalize coordinates](part01_normalize_coordinates.md)
1. [Part 2 — Recenter](part02_recenter.md)
1. [Part 3 — Distance (Pythagoras) draws a circle](part03_distance.md)
1. [Part 4 — Antialias with smoothstep](part04_antialias_smoothstep.md)
1. [Part 5 — SDF (Signed Distance Field)](part05_sdf.md)
1. [Part 6 — Aspect ratio](part06_aspect_ratio.md)
1. [Part 7 — Combine shapes](part07_combine_shapes.md)
1. [Part 8 — Animation](part08_animation.md)
1. [Part 9 — Color mixing](part09_color_mixing.md)
1. [Part 10 — Glow](part10_glow.md)
1. [Part 11 — Smooth union](part11_smooth_union.md)
1. [Part 12 — Interactivity](part12_interactivity.md)

---

## Math & Concept Cheatsheet (pin this)

* **Normalize pixels:** `uv = fragCoord / iResolution.xy` → `uv∈[0,1]^2`
  *Reason:* resolutions differ; UVs don’t.
* **Recenter:** `p = uv*2 - 1` → origin at screen center
  *Reason:* geometry is symmetric around (0,0).
* **Aspect fix:** `p.x *= width/height`
  *Reason:* prevents circles turning into ellipses on wide screens.
* **Distance (Pythagoras):** `length(p) = sqrt(x² + y²)`
  *Reason:* distance to center = circle test vs radius.
* **Circle equation:** `x² + y² = r²` ⇔ `length(p) = r`
* **SDF (circle):** `sd = length(p - c) - r`
  *Sign:* sd<0 inside, sd=0 edge, sd>0 outside.
* **Edges:** `step` (hard), `smoothstep` (soft & anti-aliased).
* **Booleans:** union `min`, intersection `max`, difference `max(a,-b)`.
* **Smooth union:** `smin(a,b,k)` for blobby blends.
* **Animation:** `(cos t, sin t)` gives circular motion; tweak phase/speed.
* **Color:** `mix(a,b,t)` for gradients & tints; `t` from space (`uv`) or time.
* **Glow:** falloff `exp(-k·max(sd,0))` → halo controlled by `k`.

---

## Prompt Ideas (encourage exploration)

* Change radius/speeds; add a third circle.
* Swap `min` ↔ `smin` and compare silhouettes.
* Color by `uv.y` or by `sd` (e.g., heatmaps).
* Make a pulsing circle: use `r = 0.3 + 0.05*sin(iTime*3.0)`.
* Tile space with `mod(p, cellSize)` for patterns.

---

## Troubleshooting

* **Squashed circles:** forgot the aspect fix → apply `p.x *= iResolution.x / iResolution.y`.
* **Aliasing/jagged edges:** increase the `blur` range in `smoothstep`.
* **Too bright glow:** reduce glow strength or increase tightness.
* **Nothing shows:** check your value ranges; try visualizing intermediates (e.g., output `vec3(uv,0)` or `vec3(sd)` scaled).

---

### Optional Next Steps

* Add other SDF shapes (box, rounded box, line, ring), morph between them.
* Introduce `max` for intersections and sculpt interesting forms.
* Use `fract`/`mod` to repeat space for kaleidoscopic patterns.

---

*Have fun — you’re literally painting with equations, at GPU speed!*


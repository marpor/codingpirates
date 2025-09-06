---
title: Shaders Workshop - Painting with Math
---
# {{ page.title }}

In this tutorial we will build a shader that looks like this - step by step:

<p><iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/wfBcDD" allowfullscreen></iframe></p>

# Quick Start

1. Open [ShaderToy](https://www.shadertoy.com)
2. Click **New** at the top-right corner.

# Step by Step

- [Part 0 - Hello, GPU](part00_hello_gpu.md)
- [Part 1 - Normalize coordinates](part01_normalize_coordinates.md)
- [Part 2 - A single circle](part02_single_circle.md)
- [Part 3 - Soft edges (SDF + smoothstep)](part03_soft_edges.md)
- [Part 4 - Simple animation](part04_animation.md)
- [Part 5 - Many circles (loops)](part05_many_circles.md)
- [Part 6 - Color palettes](part06_color_palettes.md)
- [Part 7 - Final shader (polish + parameters)](part07_final_shader.md)
<!-- - [Part 8 - Extensions (optional)](part08_extensions.md)-->

# Math & Concept Cheatsheet

* **Centered UV:** `uv = (fragCoord*2.0 - iResolution.xy)/iResolution.y`
  *Reason:* resolution-independent, origin at center.
* **Circle distance:** `length(uv - center)`
  *Reason:* points with equal distance form a circle.
* **Soft edges:** `smoothstep` vs `step`
  *Reason:* anti-aliased transitions.
* **Signed ring distance:** `sd = abs(dist - radius)`
  *Reason:* fade based on distance from ideal circle edge.
* **Animation:** drive values with `iTime`, `sin`, `cos`.
* **Loops:** `for (float i = 0.0; i < N; i++)` to repeat shapes.
* **Color:** cosine palette `a + cos(3.0*(a*t + b))`.

# Prompt Ideas

* Change radius/speeds; add more circles.
* Swap palette parameters for different moods.
* Animate color separately from motion.
* Tie motion to mouse input.

# Troubleshooting

* **Aliasing/jagged edges:** increase the `smoothstep` width.
* **Nothing shows:** check your value ranges; try visualizing intermediates.
* **Too slow:** reduce circle count or blur radius.

# Optional Next Steps

* Add other SDF shapes (box, line, ring) and animate them.
* Experiment with post-process blur or feedback effects.
* Use `fract`/`mod` to repeat space for patterns.

---

*Have fun - you’re literally painting with equations, at GPU speed!*

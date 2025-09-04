---
title: Part 8 — Extensions (optional)
---
# {{ page.title }}

These are optional explorations your students can toggle on/off.

### A. Post “blur” (cheap, approximate)

Sample a few neighbours and average. (This is a **post** effect; keep kernel tiny—too big is slow.)

```glsl
// After computing 'col' (before writing fragColor):
vec3 blurCol = vec3(0.0);
vec2 px = 1.0 / iResolution.xy;      // pixel size in UV of fragCoord-space

// tiny cross-kernel in screen space
blurCol += texture(iChannel0, fragCoord / iResolution.xy).rgb; // if you have an input; else, skip
// If no iChannel0, emulate by re-evaluating your scene at small uv offsets (costly).
// For teaching, explain idea rather than enabling by default.

vec3 mixed = mix(col, blurCol, 0.0);  // keep 0.0 unless you actually compute blurCol
```

> Note: In pure ShaderToy without textures, true post-blur means re-running your scene at neighbour UVs. Keep the kernel tiny (e.g. 5 taps) to stay fast.

### B. More color mixing

* Mix two palettes: `mix(palette(t), palette(t+0.5), 0.5)`.
* Index-based accents: add a thin highlight when `fract(i*0.618+ t*0.1) < 0.1`.

### C. Interactivity

* React to mouse: `vec2 m = (iMouse.z>0.) ? (iMouse.xy*2.0 - iResolution.xy)/iResolution.y : vec2(0.0);`
* Tie `center` or `radius` to `m`.

**What’s new**

* Demonstrated the concept of post-process blur and more playful color mixing.

[Back: Part 7 — Final shader](part07_final_shader.md)

---
title: Part 2 — Recenter
---
# {{ page.title }}

**New concept:** Shift to a symmetric math space with the origin at screen center.
**Why:** Most geometry (circles, distances) is cleaner around (0,0).

* `p = uv * 2 - 1` maps [0,1] → [-1,1]; center becomes (0,0)

**What changed:** Introduce `p` and draw simple axis tints.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy; 
    vec2 p  = uv * 2.0 - 1.0; // center is now (0,0)

    // Visual hint: tint blue where x>0, red where y>0
    vec3 col = vec3(0.0);
    col.b += smoothstep(0.0, 0.01, p.x); // +x
    col.r += smoothstep(0.0, 0.01, p.y); // +y
    fragColor = vec4(col, 1.0);
}
```

> **Math note:** Recentering is an *affine transformatio*: scale by 2 (stretch [0,1] to [0,2]) then subtract 1 (shift to [-1,1]).


### Further reading
- [The Book of Shaders — Shaping functions](https://thebookofshaders.com/05/)
- [Wikipedia — Affine transformation](https://en.wikipedia.org/wiki/Affine_transformation)

[Next: Part 3 — Distance (Pythagoras) draws a circle](part03_distance.md)

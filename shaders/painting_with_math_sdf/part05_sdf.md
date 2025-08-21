---
title: Part 5 — SDF (Signed Distance Field)
---
# {{ page.title }}

**New concept:** An **SDF** returns **signed** distance to a shape:
negative inside, zero on the boundary, positive outside.

* For a circle centered at `c` with radius `r`:
  `sd = length(p - c) - r`

**What changed:** Use an explicit SDF function.

```glsl
float sdfCircle(vec2 p, vec2 c, float r) {
    return length(p - c) - r; // <0 inside, =0 edge, >0 outside
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 p  = uv * 2.0 - 1.0;

    float sd   = sdfCircle(p, vec2(0.0), 0.5);
    float blur = 0.01;

    float edge = smoothstep(0.0, blur, sd); // soften around sd=0
    fragColor  = vec4(vec3(1.0 - edge), 1.0);
}
```

> **Why SDFs rock:** One formula gives you inside/outside, outlines, soft edges, morphing, boolean ops (union/intersection), glow, and more — all from distance.


### Further reading
- [Inigo Quilez — 2D distance functions](https://iquilezles.org/articles/distfunctions2d/)
- [GLSL reference for length](https://registry.khronos.org/OpenGL-Refpages/gl4/html/length.xhtml)

[Next: Part 6 — Aspect ratio](part06_aspect_ratio.md)

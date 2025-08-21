---
title: Part 3 — Distance (Pythagoras) draws a circle
---
# {{ page.title }}

**New concept:** Distance to the origin via **Pythagoras**:
`length(p) = sqrt(p.x² + p.y²)`

* Circle equation: **x² + y² = r²**
* Therefore, a point is **inside** the circle if `x² + y² < r²` (equivalently `length(p) < r`).

**What changed:** Threshold the distance for a hard-edged disc.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 p  = uv * 2.0 - 1.0;

    float r = 0.5;             // radius in [-1,1] space
    float d = length(p);       // sqrt(x^2 + y^2)

    float inside = step(d, r); // 1 inside, 0 outside
    fragColor = vec4(vec3(inside), 1.0);
}
```


### Further reading
- [The Book of Shaders — Shapes](https://thebookofshaders.com/03/)
- [GLSL reference for length](https://registry.khronos.org/OpenGL-Refpages/gl4/html/length.xhtml)

[Next: Part 4 — Antialias with smoothstep](part04_antialias_smoothstep.md)

---
title: Part 2 — A Single Circle
---
# {{ page.title }}

Circles show up everywhere—from bubbles to planets. In math, a circle means every point is the same distance from one center point. We'll teach the shader this rule so it can paint a perfect circle for us.

A circle is just “all points at distance `r` from a center”. Distance in 2D is `length(uv - center)`.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    // Circle parameters
    vec2  center = vec2(0.0, 0.0); // center at origin
    float radius = 0.6;

    // Distance from this pixel to the circle center
    float dist = length(uv - center);

    // 1.0 inside the circle, 0.0 outside
    float c = step(dist, radius);

    // White circle on black
    vec3 col = vec3(c);

    fragColor = vec4(col, 1.0);
}
```

### Further reading
- [Inigo Quilez — 2D distance functions](https://iquilezles.org/articles/distfunctions2d/)
- [GLSL reference for length](https://registry.khronos.org/OpenGL-Refpages/gl4/html/length.xhtml)

[Back: Part 1 — Normalize coordinates](part01_normalize_coordinates.md)

[Next: Part 3 — Soft edges (sdf + smoothstep)](part03_soft_edges.md)

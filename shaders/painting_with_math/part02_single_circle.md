---
title: Part 2 — A Single Circle
---
# {{ page.title }}


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

[Next: Part 3 — Soft edges (sdf + smoothstep)](part03_soft_edges.md)

---
title: Part 2 - A Single Circle
---
# {{ page.title }}

Circles show up everywhere—from bubbles to planets. In math, a circle means every point is the same distance from one center point. We'll teach the shader this rule so it can paint a perfect circle for us.

A circle is just “all points at distance `r` from a center”. That distance comes from the **Pythagorean theorem**: for `dx` and `dy`, `distance = sqrt(dx*dx + dy*dy)`. Comparing it with the radius is the classic circle equation `x^2 + y^2 = r^2` in disguise. GLSL's `length` function crunches that square-root math for us, so `length(uv - center)` does it all.

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

It should now look like this:

<p><iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/Wc2yWV" allowfullscreen></iframe></p>


### Further reading
- [Khan Academy — Distance formula & Pythagorean theorem](https://www.khanacademy.org/math/geometry/hs-geo-analytic-geometry/hs-geo-distance-between-points/a/distance-formula)
- [Khan Academy — Equation of a circle](https://www.khanacademy.org/math/geometry/hs-geo-analytic-geometry/hs-geo-circle-equations/v/equation-of-a-circle)
- [Inigo Quilez — 2D distance functions](https://iquilezles.org/articles/distfunctions2d/)
- [GLSL reference for length](https://registry.khronos.org/OpenGL-Refpages/gl4/html/length.xhtml)

[Back: Part 1 — Normalize coordinates](part01_normalize_coordinates.md)

[Next: Part 3 — Soft edges (sdf + smoothstep)](part03_soft_edges.md)

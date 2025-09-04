---
title: Part 4 — Simple animation
---
# {{ page.title }}

Let’s move the circle with time (`iTime`, seconds). Sinusoidal motion keeps values in `[-1, 1]`.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    float t = iTime * 0.75;            // animation speed

    // Move the center along a lissajous-like path
    vec2 center = vec2(sin(t*1.7), cos(t*1.1)) * 0.4;
    float radius = 0.6;

    float dist = length(uv - center);
    float sd   = abs(dist - radius);

    float smoothingRadius = 0.01;
    float c = smoothstep(smoothingRadius, 0.0, sd);

    vec3 col = vec3(c);

    fragColor = vec4(col, 1.0);
}
```

**What’s new**

* Introduced **time** to animate position.

[Back: Part 3 — Soft edges](part03_soft_edges.md) • [Next: Part 5 — Many circles (loops)](part05_many_circles.md)

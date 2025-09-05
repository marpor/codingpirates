---
title: Part 3 - Soft edges (SDF + smoothstep)
---
# {{ page.title }}

Straight-cut shapes can look jagged, like old video game graphics. To make things smoother we measure how far each pixel is from the perfect edge and fade the color as we move away. This idea is called a *signed distance function* (SDF) or sometimes *signed distance field*, and it lets us draw soft outlines without blurry images.

Let’s build a tiny “soft edge” with an **SDF** (signed distance function) idea for a circle:
`sd = abs(dist - radius)` is small near the ring. Then we smooth it.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    vec2  center = vec2(0.0);
    float radius = 0.6;

    float dist = length(uv - center);

    // How far from the ideal ring (distance == radius)?
    float sd = abs(dist - radius);

    // Smooth ring: c=1 at circle edge, fades away with width 'smoothingRadius'
    float smoothingRadius = 0.01;      // try 0.02, 0.05, ...
    float c = smoothstep(smoothingRadius, 0.0, sd);

    vec3 col = vec3(c);

    fragColor = vec4(col, 1.0);
}
```

It should now look like this:

<p><iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/WfjcWV" allowfullscreen></iframe></p>


**What’s new**

* Switched from `step` to **`smoothstep`** for anti-aliased edges.
* Used `sd = abs(dist - radius)` to make a **ring**. (If you want a filled circle, use `c = 1.0 - smoothstep(radius, radius + smoothingRadius, dist);`)

### Further reading
- [Inigo Quilez — Signed distance functions](https://iquilezles.org/articles/distfunctions/)
- [Wikipedia - Signed distance function](https://en.wikipedia.org/wiki/Signed_distance_function)
- [GLSL reference for smoothstep](https://registry.khronos.org/OpenGL-Refpages/gl4/html/smoothstep.xhtml)

[Back: Part 2 — A single circle](part02_single_circle.md)

[Next: Part 4 — Simple animation](part04_animation.md)

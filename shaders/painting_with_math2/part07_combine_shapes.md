---
title: Part 7 — Combine shapes
---
# {{ page.title }}

**New concept:** **Boolean ops** on SDFs:

* Union: `min(sd1, sd2)`
* Intersection: `max(sd1, sd2)`
* Difference: `max(sd1, -sd2)`

**What changed:** Two circles → union via `min`.

```glsl
float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv      = fragCoord / iResolution.xy;
    vec2 p       = uv * 2.0 - 1.0;
    float aspect = iResolution.x / iResolution.y;
    p.x *= aspect;

    float sd1 = sdfCircle(p, vec2(-0.4, 0.0), 0.5);
    float sd2 = sdfCircle(p, vec2( 0.4, 0.0), 0.5);

    float sd   = min(sd1, sd2);           // union
    float edge = smoothstep(1.0, 0.01, sd);
    fragColor  = vec4(vec3(edge), 1.0);
}
```


### Further reading
- [Inigo Quilez — Distance functions](https://iquilezles.org/articles/distfunctions/)
- [GLSL reference for min/max](https://registry.khronos.org/OpenGL-Refpages/gl4/html/min.xhtml)

[Next: Part 8 — Animation](part08_animation.md)

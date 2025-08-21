---
title: Part 11 — Smooth union
---
# {{ page.title }}

**New concept:** Replace sharp `min` with **smooth min `smin`** to blend shapes organically.
Parameter `k` controls softness (larger = softer).

**What changed:** Use `smin` when combining SDFs.

```glsl
float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }

// Smooth min blend (IQ-style)
float smin(float a, float b, float k){
    float h = clamp(0.5 + 0.5*(b - a)/k, 0.0, 1.0);
    return mix(b, a, h) - k*h*(1.0 - h);
}
```

Use it instead of `min(sd1, sd2)`:

```glsl
float sd = smin(sd1, sd2, 0.25); // try k in [0.05 .. 0.5]
```


### Further reading
- [Inigo Quilez — Smooth minimum](https://iquilezles.org/articles/smin/)
- [GLSL reference for mix](https://registry.khronos.org/OpenGL-Refpages/gl4/html/mix.xhtml)

[Next: Part 12 — Interactivity](part12_interactivity.md)

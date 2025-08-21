---
title: Part 4 — Antialias with `smoothstep`
---
# {{ page.title }}

**New concept:** Replace a hard threshold with a **soft transition**.
`smoothstep(a,b,x)` smoothly maps x from 0→1 over [a,b].

**What changed:** Feather the rim by blending around the radius.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 p  = uv * 2.0 - 1.0;

    float r    = 0.5;
    float blur = 0.01;                  // softness width
    float d    = length(p);

    float edge = smoothstep(r, r + blur, d); // 0 inside, 1 outside
    fragColor  = vec4(vec3(1.0 - edge), 1.0); // white disc, soft rim
}
```

> **Math note:** `smoothstep` is a cubic polynomial with zero slope at `a` and `b`, reducing aliasing.


### Further reading
- [The Book of Shaders — Shaping functions](https://thebookofshaders.com/05/)
- [GLSL reference for smoothstep](https://registry.khronos.org/OpenGL-Refpages/gl4/html/smoothstep.xhtml)

[Next: Part 5 — SDF (Signed Distance Field)](part05_sdf.md)

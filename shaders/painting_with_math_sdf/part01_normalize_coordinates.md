---
title: Part 1 — Normalize coordinates
---
# {{ page.title }}

**New concept:** **Normalization**: convert pixels → unit square.
**Why:** Makes math **resolution-independent** and easier to reason about.

* `uv = fragCoord / iResolution.xy`
* Bottom-left ≈ (0,0), top-right ≈ (1,1), center ≈ (0.5,0.5)

**What changed:** Compute `uv` and visualize a gradient.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy; // normalize pixels into [0,1]^2
    fragColor = vec4(uv.x, uv.x, uv.x, 1.0); // left→right grey ramp
}
```


### Further reading
- [The Book of Shaders — Uniforms](https://thebookofshaders.com/02/)
- [GLSL reference for vec2](https://registry.khronos.org/OpenGL-Refpages/gl4/html/vec.xhtml)

[Next: Part 2 — Recenter](part02_recenter.md)

---
title: Part 6 — Aspect ratio
---
# {{ page.title }}

**New concept:** Fix stretch from non-square viewports: scale x by `aspect = width/height`.

**What changed:** Apply aspect to the *math* space `p`.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv      = fragCoord / iResolution.xy;
    vec2 p       = uv * 2.0 - 1.0;
    float aspect = iResolution.x / iResolution.y;
    p.x *= aspect; // prevent ellipse distortion

    float sd   = length(p) - 0.5;
    float edge = smoothstep(0.0, 0.01, sd);
    fragColor  = vec4(vec3(1.0 - edge), 1.0);
}
```

> **Math note:** This is a linear scaling in x; conceptually, you’re undoing the screen’s horizontal stretch in your compute space.


### Further reading
- [The Book of Shaders — Shapes](https://thebookofshaders.com/03/)
- [Wikipedia — Aspect ratio](https://en.wikipedia.org/wiki/Aspect_ratio_(image))

[Next: Part 7 — Combine shapes](part07_combine_shapes.md)

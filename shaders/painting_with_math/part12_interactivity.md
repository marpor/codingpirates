---
title: Part 12 — Interactivity
---
# {{ page.title }}

**New concept:** Use `iMouse.xy` to control a shape.
**What changed:** Convert mouse pixels → UV → centered → aspect-corrected.

```glsl
float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv      = fragCoord / iResolution.xy;
    vec2 p       = uv * 2.0 - 1.0;
    float aspect = iResolution.x / iResolution.y;
    p.x *= aspect;

    // If mouse is down (iMouse.z>0), place circle at mouse; else center
    vec2 muv = iMouse.z > 0.0 ? (iMouse.xy / iResolution.xy) : vec2(0.5);
    vec2 mc  = muv * 2.0 - 1.0;
    mc.x *= aspect;

    float sd   = sdfCircle(p, mc, 0.3);
    float edge = smoothstep(0.0, 0.01, sd);

    vec3 bg  = vec3(0.05,0.07,0.10);
    vec3 ink = vec3(0.85,0.65,0.30);

    vec3 col = mix(bg, ink, 1.0 - edge);
    fragColor = vec4(col, 1.0);
}
```



### Further reading
- [The Book of Shaders — Uniforms](https://thebookofshaders.com/02/)
- [Shadertoy docs — iMouse](https://www.shadertoy.com/howto)

[Back to workshop overview](index.md)

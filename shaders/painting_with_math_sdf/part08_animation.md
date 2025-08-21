---
title: Part 8 — Animation
---
# {{ page.title }}

**New concept:** Animate positions over time with sine/cosine.
**Why:** `sin`/`cos` give smooth periodic motion (circles/ellipses/Lissajous).

**What changed:** Circle centers move with time.

```glsl
float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv      = fragCoord / iResolution.xy;
    vec2 p       = uv * 2.0 - 1.0;
    float aspect = iResolution.x / iResolution.y;
    p.x *= aspect;

    vec2 c1 = vec2(-0.3 + 0.25*cos(iTime*0.8),  0.20 + 0.20*sin(iTime*0.7));
    vec2 c2 = vec2( 0.3 + 0.25*sin(iTime*0.9), -0.20 + 0.20*cos(iTime*0.6));

    float sd = min(sdfCircle(p, c1, 0.35),
                   sdfCircle(p, c2, 0.35));

    float edge = smoothstep(0.0, 0.01, sd);
    fragColor  = vec4(vec3(1.0 - edge), 1.0);
}
```

> **Math note:** `(cos t, sin t)` traces a unit circle; scaling components gives ellipses; using different speeds/phases creates interesting paths.


### Further reading
- [The Book of Shaders — Time](https://thebookofshaders.com/07/)
- [GLSL reference for sin and cos](https://registry.khronos.org/OpenGL-Refpages/gl4/html/sin.xhtml)

[Next: Part 9 — Color mixing](part09_color_mixing.md)

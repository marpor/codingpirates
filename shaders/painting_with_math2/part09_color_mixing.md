---
title: Part 9 — Color mixing
---
# {{ page.title }}

**New concept:** Interpolate colors with `mix(a,b,t)` where `t∈[0,1]`.

**What changed:** A background gradient + time-cycling tint on shapes.

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

    // Background gradient
    vec3 bg  = mix(vec3(0.08,0.10,0.18), vec3(0.18,0.10,0.08), uv.x);

    // Time-varying tint: phase-shifted sines for R,G,B
    vec3 tint = 0.5 + 0.5 * vec3(
        sin(iTime*0.6 + 0.0),
        sin(iTime*0.6 + 2.1),
        sin(iTime*0.6 + 4.2)
    );

    float edge = smoothstep(0.0, 0.01, sd);
    vec3  col  = mix(bg, tint, 1.0 - edge); // draw shape over bg

    fragColor = vec4(col, 1.0);
}
```


### Further reading
- [The Book of Shaders — Color](https://thebookofshaders.com/04/)
- [GLSL reference for mix](https://registry.khronos.org/OpenGL-Refpages/gl4/html/mix.xhtml)

[Next: Part 10 — Glow](part10_glow.md)

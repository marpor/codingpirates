---
title: Part 10 — Glow
---
# {{ page.title }}

**New concept:** Use SDF to build a **glow** via exponential falloff for `sd>0`.

**What changed:** Add an additive halo based on positive distance.

```glsl
float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }

float glowFromSDF(float sd, float strength, float tightness){
    float g = exp(-tightness * max(sd, 0.0)); // decay outside the edge
    return clamp(g * strength, 0.0, 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv      = fragCoord / iResolution.xy;
    vec2 p       = uv * 2.0 - 1.0;
    float aspect = iResolution.x / iResolution.y;
    p.x *= aspect;

    vec2 c1 = vec2(-0.3 + 0.25*cos(iTime*0.8),  0.20 + 0.20*sin(iTime*0.7));
    vec2 c2 = vec2( 0.3 + 0.25*sin(iTime*0.9), -0.20 + 0.20*cos(iTime*0.6));

    float sd1 = sdfCircle(p, c1, 0.35);
    float sd2 = sdfCircle(p, c2, 0.35);
    float sd  = min(sd1, sd2);

    vec3 bg   = mix(vec3(0.06,0.06,0.10), vec3(0.13,0.10,0.08), uv.x);
    vec3 tint = 0.5 + 0.5 * vec3(
        sin(iTime*0.6 + 0.0),
        sin(iTime*0.6 + 2.1),
        sin(iTime*0.6 + 4.2)
    );

    float edge = smoothstep(0.0, 0.01, sd);
    vec3  base = mix(bg, tint, 1.0 - edge);

    float glow = glowFromSDF(sd, 0.9, 8.0);
    vec3  col  = base + tint * glow * 0.6; // additive halo

    fragColor = vec4(col, 1.0);
}
```

> **Math note:** Exponential decay `e^{-k·sd}` gives a smooth halo whose width is controlled by `k` (“tightness”).


### Further reading
- [Inigo Quilez — Distance functions](https://iquilezles.org/articles/distfunctions/)
- [GLSL reference for exp](https://registry.khronos.org/OpenGL-Refpages/gl4/html/exp.xhtml)

[Next: Part 11 — Smooth union](part11_smooth_union.md)

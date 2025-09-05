---
title: Part 6 — Color palettes
---
# {{ page.title }}

Our circles have been plain so far. Screens make color by blending red, green, and blue light. If we choose those numbers carefully, we can get beautiful gradients. A *palette* function turns one number into a matching set of colors, giving our art a coordinated look.

We’ll color each circle using a compact cosine palette. Small changes in `t` produce smooth, rich colors.

```glsl
// Cosine palette
vec3 palette(float t)
{
    // Numbers chosen here semi-randomly. Try adjusting the different numbers to get colors you like
    vec3 a = vec3(1.0);
    vec3 b = vec3(0.123, 0.456, 0.789);
    return a + cos(3.0 * (a * t + b));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    float t = iTime * 0.25;            // slower time for color

    vec3 col = vec3(0.0);

    const float N = 12.0;
    for (float i = 0.0; i < N; i++)
    {
        vec2 center = vec2(
            sin(3.1*i + 0.8*t),
            cos(2.3*i - 0.6*t)
        ) * 0.7;

        float radius = 1.2 - i/(N*2.0);
        float dist   = length(uv - center);
        float sd     = abs(dist - radius);

        float smoothingRadius = 0.02;
        float c = smoothstep(smoothingRadius, 0.0, sd);

        // Color per circle; pow adds contrast
        col += pow(c*1.1, 3.0) * palette(t + i*0.07);
    }

    col /= N;

    fragColor = vec4(col, 1.0);
}
```

**What’s new**

* Added a **palette** function and mixed color per-circle.
* Used **`pow`** to boost contrast.

### Further reading
- [Inigo Quilez — Color palettes](https://iquilezles.org/articles/palettes/)
- [The Book of Shaders — Color](https://thebookofshaders.com/05/)

[Back: Part 5 — Many circles](part05_many_circles.md)

[Next: Part 7 — Final shader polish](part07_final_shader.md)

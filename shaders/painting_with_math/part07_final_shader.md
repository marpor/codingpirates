---
title: Part 7 — Final shader (polish + parameters)
---
# {{ page.title }}

We’ll crank up the count, tune motion via incommensurate frequencies, and match the target structure.

```glsl
// Smooth cosine palette: returns a nice RGB for input t
vec3 palette(float t)
{
    vec3 a = vec3(1.0);
    vec3 b = vec3(0.123, 0.456, 0.789);
    return a + cos(3.0 * (a * t + b));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Centered, aspect-correct coordinates
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    // Slow global time for motion and color
    float t = iTime * 0.125;

    // Accumulated color
    vec3 col = vec3(0.0);

    // Circle count
    const float N = 15.0;
    for (float i = 0.0; i < N; i++)
    {
        // Move center around, offset by some multiple of i
        vec2 center = vec2(
            sin(53.0*i + 0.15*t*i),
            sin(21.0*i - 0.52*t*i)
        );

        // Distance from current pixel to this circle's center
        float dist = length(uv - center);

        // Make radius a bit smaller for each circle
        float radius = 1.5 - i/(N*3.0);

        // Signed Distance (ring distance)
        float sd = abs(dist - radius);

        // Smoothen circle (bigger width fits our scale)
        float smoothingRadius = 0.75;
        float c = smoothstep(smoothingRadius, 0.0, sd);

        // Pick a color using palette, and use pow for increased contrast
        col += pow(1.25*c, 5.0) * palette(t * i / 28.0);
    }

    // Average contributions
    col /= N;

    fragColor = vec4(col, 1.0);
}
```

**What’s new**

* Increased **N** and used **incommensurate frequencies** for richer motion.
* Scaled **smoothing** to the scene and boosted contrast with `pow`.
* Final **palette** timing ties color to circle index for variety.

[Back: Part 6 — Color palettes](part06_color_palettes.md) • [Next: Part 8 — Extensions (optional)](part08_extensions.md)

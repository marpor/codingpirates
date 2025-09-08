---
title: Part 5 - Many circles (loops)
---
# {{ page.title }}

Computers love repetition—they can do the same job thousands of times in a blink. Instead of writing code for every single circle, we'll use a loop to repeat the drawing steps. Each pass through the loop tweaks the circle's position and size, giving us a swarm of shapes with very little code.

Now we’ll draw **N** circles in a loop, offsetting each center and shrinking the radius a bit.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    float t = iTime * 0.5;

    vec3 col = vec3(0.0);              // accumulate here

    const float N = 12.0;              // number of circles
    for (float i = 0.0; i < N; i++)
    {
        // Each circle gets a different center and radius, 
        // we multiply by i to get some variation
        vec2 center = vec2(
            sin(3.1*i + 0.8*t),
            cos(2.3*i - 0.6*t)
        ) * 0.7;

        // Vary radius for each circle
        float radius = 1.2 - i/(N*2.0);

        float dist = length(uv - center);
        float sd   = abs(dist - radius);

        float smoothingRadius = 0.02;
        float c = smoothstep(smoothingRadius, 0.0, sd);

        // Add brighter contribution for stronger circles
        col += vec3(pow(c, 2.0));
    }

    col /= N;                           // average

    fragColor = vec4(col, 1.0);
}
```

It should now look like this:

<p><iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/Wcffz8" allowfullscreen></iframe></p>

**What’s new**

* Introduced a **for-loop** to place many circles.
* **Accumulate** contributions and average.

### Further reading
- [GLSL iteration]https://learnwebgl.brown37.net/12_shader_language/glsl_control_structures.html#iteration)


[Back: Part 4 — Animation](part04_animation.md)

[Next: Part 6 — Color palettes](part06_color_palettes.md)

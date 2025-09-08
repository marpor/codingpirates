---
title: Part 4 - Simple animation
---
# {{ page.title }}

Static images are cool, but animation brings them to life. ShaderToy gives us a handy timer called `iTime` that tells us how many seconds have passed. By plugging that timer into math functions like `sin` and `cos`, we can make our shapes glide and bounce without any complicated logic.

Let’s move the circle with time (`iTime`, seconds). Sinusoidal motion keeps values in `[-1, 1]`.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    float t = iTime * 0.75; // animation speed

    // Move the center with different frequency along x and y, up to 0.4 away from the middle
    vec2 center = vec2(
            sin(t*2.7), 
            sin(t*2.1)
        ) * 0.4;
        
    float radius = 0.6;

    float dist = length(uv - center);
    float sd   = abs(dist - radius);

    float smoothingRadius = 0.01;
    float c = smoothstep(smoothingRadius, 0.0, sd);

    vec3 col = vec3(c);

    fragColor = vec4(col, 1.0);
}
```

It should now look like this:

<p><iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/3cffz8" allowfullscreen></iframe></p>

### Further reading

- [sin - Book of Shaders](https://thebookofshaders.com/glossary/?search=sin)
- [sin - GeoGebra](https://www.geogebra.org/calculator/zej9tece)
- [Shadertoy — Uniforms (iTime)](https://www.shadertoy.com/howto#time)

[Back: Part 3 — Soft edges](part03_soft_edges.md)

[Next: Part 5 — Many circles (loops)](part05_many_circles.md)

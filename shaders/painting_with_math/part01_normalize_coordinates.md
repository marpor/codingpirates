---
title: Part 1 — Normalize coordinates
---
# {{ page.title }}

Pixels arrive in **screen coordinates** (`fragCoord`) like `(x, y)` in pixels. To make math easier, we’ll convert to a centered, square-ish space called **uv**:

* origin `(0,0)` in the **center**
* `x` grows right, `y` grows up
* both roughly in the range `[-1, +1]`

Paste this:

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Normalize to a centered, aspect-correct coordinate system
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;

    // Visualize axes: X to red, Y to green (mapped from [-1,1] to [0,1])
    vec3 col = vec3(uv*0.5 + 0.5, 0.0);

    fragColor = vec4(col, 1.0);
}
```

**What’s new vs Part 0**

* Introduced a centered `uv` space.
* Showed a quick gradient to prove it works.

[Next: Part 2 — A single circle](part02_single_circle.md)

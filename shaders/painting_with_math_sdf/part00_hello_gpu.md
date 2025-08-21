---
title: Part 0 — Hello, GPU
---
# {{ page.title }}

**New concept:** A fragment shader runs once per pixel and outputs a color.

**What changed:** Return a constant color.

```glsl
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // fragCoord = current pixel coordinate in screen pixels (x,y)
    // iResolution = total screen size in pixels (x,y)
    fragColor = vec4(0.10, 0.10, 0.12, 1.0); // solid dark grey
}
```


### Further reading
- [The Book of Shaders — Hello World](https://thebookofshaders.com/01/)
- [GLSL fragment shader basics](https://www.khronos.org/opengl/wiki/Fragment_Shader)

[Next: Part 1 — Normalize coordinates](part01_normalize_coordinates.md)

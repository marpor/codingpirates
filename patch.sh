 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a/index.md b/index.md
index b97b0af746d1ac0015feee4bbabff676e87f42ab..e8da2249758ac5c17488d3ad6192c3614ef1d745 100644
--- a/index.md
+++ b/index.md
@@ -17,47 +17,51 @@ This page holds a collection of materials that I use in my [Coding Pirates](http
 Templates / Demo Projects
 
 * [github.com/marpor/PixelAdventure](https://github.com/marpor/PixelAdventure) (Godot 3 - 2D)
 * [github.com/marpor/wiggle-ball](https://github.com/marpor/wiggle-ball) (Godot 4 - 3D)
 
 # Unity
 
 Tutorials
 
 * [Lys og Kugler 1](unity/lights_and_balls1/index.md) 🇩🇰
 * [Lys og Kugler 2](unity/lights_and_balls2/index.md) 🇩🇰
 * [Michaels Tutorials](https://github.com/mhfalken/unity) 🔗🇩🇰
 * [The Unity Tutorial for Complete Beginners](https://www.youtube.com/watch?v=XtQMytORBmM) 🔗🎬 (YouTube)
 
 Templates / Demo Projects
 
 * [github.com/marpor/BallsAndLights2_Unity](https://github.com/marpor/BallsAndLights2_Unity) (Unity - 3D)
 
 # JavaScript/CSS/HTML
 
 * [Emoji Catcher Tutorial](https://replit.com/@marpor/Emoji-Catcher-Tutorial) interactive tutorial on replit.com
 * [Emoji Clicker Template](https://replit.com/@marpor/Emoji-Clicker) template with guide on replit.com
 
 <!-- [Emoji Catcher Tutorial](emoji-catcher) -->
 
+# Shaders
+
+* [Shaders Workshop — Painting with Math (SDF Edition)](shaders/painting_with_math_sdf/index.md)
+
 # Blender
 
 ## Beginner
 
 * [A Low-Poly Mushroom](blender/mushroom.md)
 
 * [Donut Tutorial](https://www.youtube.com/watch?v=B0J27sf9N1Y) 🔗🎬 (YouTube)
 * [Blender 4 for Absolute Beginners](https://www.youtube.com/watch?v=lLqep5Q4MiI&ab_channel=GrantAbbitt%28Gabbitt%29) 🔗🎬 (YouTube)
 * [More Grant Abbitts Tutorials](https://www.youtube.com/@grabbitt/playlists) 🔗🎬 (YouTube)
 * [CBailey's Tie Fighter Tutorial](https://www.youtube.com/watch?v=SVl_tlbGrh4&ab_channel=CBaileyFilm) 🔗🎬 (YouTube)
 
 ## Intermediate
 
 * [6 Blender Hard-Surface Modeling Tricks I Wish I Knew Earlier](https://www.youtube.com/watch?v=Ml2t8uxPAQU&ab_channel=CGBoost)  🔗🎬 (YouTube)
 
 # Other
 
 I highly recommend watching Sebastian Lague's excellent [Coding Adventures](https://www.youtube.com/@SebastianLague) videos. He's exploring various topics using Unity, but the learnings and experiences are well worth a watch no matter what your preferred engine or programming language.
 
 Enjoy!
 
 /Marken
diff --git a/shaders/painting_with_math_sdf/index.md b/shaders/painting_with_math_sdf/index.md
new file mode 100644
index 0000000000000000000000000000000000000000..1817ad59a0f9f4c62325d65a927337be666231ff
--- /dev/null
+++ b/shaders/painting_with_math_sdf/index.md
@@ -0,0 +1,90 @@
+---
+title: Shaders Workshop — Painting with Math (SDF Edition)
+---
+# {{ page.title }}
+
+**Audience:** Ages 13–17 with basic coding experience  
+**Tool:** [ShaderToy](https://www.shadertoy.com) (fragment shader only)  
+**Goal:** Build up, one concept at a time, from a single circle to an animated, glowing, colorful scene — while learning the math behind it (UVs, Pythagoras, SDFs, mixing, etc.).
+
+---
+
+## Quick Start
+
+1. Open ShaderToy → **New Shader**.
+2. You’ll edit the `mainImage` function only.
+3. A **fragment shader** runs once **per pixel** to decide that pixel’s color — massively in parallel on the GPU.
+
+> Mental model: “Each pixel asks the shader: *what color should I be?* The shader answers using math.”
+
+---
+
+## Step by Step
+
+1. [Part 0 — Hello, GPU](part00_hello_gpu.md)
+1. [Part 1 — Normalize coordinates](part01_normalize_coordinates.md)
+1. [Part 2 — Recenter](part02_recenter.md)
+1. [Part 3 — Distance (Pythagoras) draws a circle](part03_distance.md)
+1. [Part 4 — Antialias with smoothstep](part04_antialias_smoothstep.md)
+1. [Part 5 — SDF (Signed Distance Field)](part05_sdf.md)
+1. [Part 6 — Aspect ratio](part06_aspect_ratio.md)
+1. [Part 7 — Combine shapes](part07_combine_shapes.md)
+1. [Part 8 — Animation](part08_animation.md)
+1. [Part 9 — Color mixing](part09_color_mixing.md)
+1. [Part 10 — Glow](part10_glow.md)
+1. [Part 11 — Smooth union](part11_smooth_union.md)
+1. [Part 12 — Interactivity](part12_interactivity.md)
+
+---
+
+## Math & Concept Cheatsheet (pin this)
+
+* **Normalize pixels:** `uv = fragCoord / iResolution.xy` → `uv∈[0,1]^2`
+  *Reason:* resolutions differ; UVs don’t.
+* **Recenter:** `p = uv*2 - 1` → origin at screen center
+  *Reason:* geometry is symmetric around (0,0).
+* **Aspect fix:** `p.x *= width/height`
+  *Reason:* prevents circles turning into ellipses on wide screens.
+* **Distance (Pythagoras):** `length(p) = sqrt(x² + y²)`
+  *Reason:* distance to center = circle test vs radius.
+* **Circle equation:** `x² + y² = r²` ⇔ `length(p) = r`
+* **SDF (circle):** `sd = length(p - c) - r`
+  *Sign:* sd<0 inside, sd=0 edge, sd>0 outside.
+* **Edges:** `step` (hard), `smoothstep` (soft & anti-aliased).
+* **Booleans:** union `min`, intersection `max`, difference `max(a,-b)`.
+* **Smooth union:** `smin(a,b,k)` for blobby blends.
+* **Animation:** `(cos t, sin t)` gives circular motion; tweak phase/speed.
+* **Color:** `mix(a,b,t)` for gradients & tints; `t` from space (`uv`) or time.
+* **Glow:** falloff `exp(-k·max(sd,0))` → halo controlled by `k`.
+
+---
+
+## Prompt Ideas (encourage exploration)
+
+* Change radius/speeds; add a third circle.
+* Swap `min` ↔ `smin` and compare silhouettes.
+* Color by `uv.y` or by `sd` (e.g., heatmaps).
+* Make a pulsing circle: use `r = 0.3 + 0.05*sin(iTime*3.0)`.
+* Tile space with `mod(p, cellSize)` for patterns.
+
+---
+
+## Troubleshooting
+
+* **Squashed circles:** forgot the aspect fix → apply `p.x *= iResolution.x / iResolution.y`.
+* **Aliasing/jagged edges:** increase the `blur` range in `smoothstep`.
+* **Too bright glow:** reduce glow strength or increase tightness.
+* **Nothing shows:** check your value ranges; try visualizing intermediates (e.g., output `vec3(uv,0)` or `vec3(sd)` scaled).
+
+---
+
+### Optional Next Steps
+
+* Add other SDF shapes (box, rounded box, line, ring), morph between them.
+* Introduce `max` for intersections and sculpt interesting forms.
+* Use `fract`/`mod` to repeat space for kaleidoscopic patterns.
+
+---
+
+*Have fun — you’re literally painting with equations, at GPU speed!*
+
diff --git a/shaders/painting_with_math_sdf/part00_hello_gpu.md b/shaders/painting_with_math_sdf/part00_hello_gpu.md
new file mode 100644
index 0000000000000000000000000000000000000000..6a13d55639714f526d55dc049f6ad54b02d54c84
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part00_hello_gpu.md
@@ -0,0 +1,23 @@
+---
+title: Part 0 — Hello, GPU
+---
+# {{ page.title }}
+
+**New concept:** A fragment shader runs once per pixel and outputs a color.
+
+**What changed:** Return a constant color.
+
+```glsl
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    // fragCoord = current pixel coordinate in screen pixels (x,y)
+    // iResolution = total screen size in pixels (x,y)
+    fragColor = vec4(0.10, 0.10, 0.12, 1.0); // solid dark grey
+}
+```
+
+
+### Further reading
+- [The Book of Shaders — Hello World](https://thebookofshaders.com/01/)
+- [GLSL fragment shader basics](https://www.khronos.org/opengl/wiki/Fragment_Shader)
+
+[Next: Part 1 — Normalize coordinates](part01_normalize_coordinates.md)
diff --git a/shaders/painting_with_math_sdf/part01_normalize_coordinates.md b/shaders/painting_with_math_sdf/part01_normalize_coordinates.md
new file mode 100644
index 0000000000000000000000000000000000000000..34ba070efd6ed570e0b14c156e96099fbdd32646
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part01_normalize_coordinates.md
@@ -0,0 +1,26 @@
+---
+title: Part 1 — Normalize coordinates
+---
+# {{ page.title }}
+
+**New concept:** **Normalization**: convert pixels → unit square.
+**Why:** Makes math **resolution-independent** and easier to reason about.
+
+* `uv = fragCoord / iResolution.xy`
+* Bottom-left ≈ (0,0), top-right ≈ (1,1), center ≈ (0.5,0.5)
+
+**What changed:** Compute `uv` and visualize a gradient.
+
+```glsl
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv = fragCoord / iResolution.xy; // normalize pixels into [0,1]^2
+    fragColor = vec4(uv.x, uv.x, uv.x, 1.0); // left→right grey ramp
+}
+```
+
+
+### Further reading
+- [The Book of Shaders — Uniforms](https://thebookofshaders.com/02/)
+- [GLSL reference for vec2](https://registry.khronos.org/OpenGL-Refpages/gl4/html/vec.xhtml)
+
+[Next: Part 2 — Recenter](part02_recenter.md)
diff --git a/shaders/painting_with_math_sdf/part02_recenter.md b/shaders/painting_with_math_sdf/part02_recenter.md
new file mode 100644
index 0000000000000000000000000000000000000000..c62e107fcee7398d341a283d07a153e23b1f4a4c
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part02_recenter.md
@@ -0,0 +1,33 @@
+---
+title: Part 2 — Recenter
+---
+# {{ page.title }}
+
+**New concept:** Shift to a symmetric math space with the origin at screen center.
+**Why:** Most geometry (circles, distances) is cleaner around (0,0).
+
+* `p = uv * 2 - 1` maps [0,1] → [-1,1]; center becomes (0,0)
+
+**What changed:** Introduce `p` and draw simple axis tints.
+
+```glsl
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv = fragCoord / iResolution.xy; 
+    vec2 p  = uv * 2.0 - 1.0; // center is now (0,0)
+
+    // Visual hint: tint blue where x>0, red where y>0
+    vec3 col = vec3(0.0);
+    col.b += smoothstep(0.0, 0.01, p.x); // +x
+    col.r += smoothstep(0.0, 0.01, p.y); // +y
+    fragColor = vec4(col, 1.0);
+}
+```
+
+> **Math note:** Recenering is an *affine transform*: scale by 2 (stretch [0,1] to [0,2]) then subtract 1 (shift to [-1,1]).
+
+
+### Further reading
+- [The Book of Shaders — Shaping functions](https://thebookofshaders.com/05/)
+- [Wikipedia — Affine transformation](https://en.wikipedia.org/wiki/Affine_transformation)
+
+[Next: Part 3 — Distance (Pythagoras) draws a circle](part03_distance.md)
diff --git a/shaders/painting_with_math_sdf/part03_distance.md b/shaders/painting_with_math_sdf/part03_distance.md
new file mode 100644
index 0000000000000000000000000000000000000000..c6e2a6a58a192a04354f76ddf9e96385d99063c0
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part03_distance.md
@@ -0,0 +1,32 @@
+---
+title: Part 3 — Distance (Pythagoras) draws a circle
+---
+# {{ page.title }}
+
+**New concept:** Distance to the origin via **Pythagoras**:
+`length(p) = sqrt(p.x² + p.y²)`
+
+* Circle equation: **x² + y² = r²**
+* Therefore, a point is **inside** the circle if `x² + y² < r²` (equivalently `length(p) < r`).
+
+**What changed:** Threshold the distance for a hard-edged disc.
+
+```glsl
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv = fragCoord / iResolution.xy;
+    vec2 p  = uv * 2.0 - 1.0;
+
+    float r = 0.5;             // radius in [-1,1] space
+    float d = length(p);       // sqrt(x^2 + y^2)
+
+    float inside = step(d, r); // 1 inside, 0 outside
+    fragColor = vec4(vec3(inside), 1.0);
+}
+```
+
+
+### Further reading
+- [The Book of Shaders — Shapes](https://thebookofshaders.com/03/)
+- [GLSL reference for length](https://registry.khronos.org/OpenGL-Refpages/gl4/html/length.xhtml)
+
+[Next: Part 4 — Antialias with smoothstep](part04_antialias_smoothstep.md)
diff --git a/shaders/painting_with_math_sdf/part04_antialias_smoothstep.md b/shaders/painting_with_math_sdf/part04_antialias_smoothstep.md
new file mode 100644
index 0000000000000000000000000000000000000000..b1488ccd756ef6fa592aa45aaa75e70ac7d8a9c8
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part04_antialias_smoothstep.md
@@ -0,0 +1,32 @@
+---
+title: Part 4 — Antialias with `smoothstep`
+---
+# {{ page.title }}
+
+**New concept:** Replace a hard threshold with a **soft transition**.
+`smoothstep(a,b,x)` smoothly maps x from 0→1 over [a,b].
+
+**What changed:** Feather the rim by blending around the radius.
+
+```glsl
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv = fragCoord / iResolution.xy;
+    vec2 p  = uv * 2.0 - 1.0;
+
+    float r    = 0.5;
+    float blur = 0.01;                  // softness width
+    float d    = length(p);
+
+    float edge = smoothstep(r, r + blur, d); // 0 inside, 1 outside
+    fragColor  = vec4(vec3(1.0 - edge), 1.0); // white disc, soft rim
+}
+```
+
+> **Math note:** `smoothstep` is a cubic polynomial with zero slope at `a` and `b`, reducing aliasing.
+
+
+### Further reading
+- [The Book of Shaders — Shaping functions](https://thebookofshaders.com/05/)
+- [GLSL reference for smoothstep](https://registry.khronos.org/OpenGL-Refpages/gl4/html/smoothstep.xhtml)
+
+[Next: Part 5 — SDF (Signed Distance Field)](part05_sdf.md)
diff --git a/shaders/painting_with_math_sdf/part05_sdf.md b/shaders/painting_with_math_sdf/part05_sdf.md
new file mode 100644
index 0000000000000000000000000000000000000000..fd51c0c2bca23fa33a656b63c86ceb56e469f8c6
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part05_sdf.md
@@ -0,0 +1,38 @@
+---
+title: Part 5 — SDF (Signed Distance Field)
+---
+# {{ page.title }}
+
+**New concept:** An **SDF** returns **signed** distance to a shape:
+negative inside, zero on the boundary, positive outside.
+
+* For a circle centered at `c` with radius `r`:
+  `sd = length(p - c) - r`
+
+**What changed:** Use an explicit SDF function.
+
+```glsl
+float sdfCircle(vec2 p, vec2 c, float r) {
+    return length(p - c) - r; // <0 inside, =0 edge, >0 outside
+}
+
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv = fragCoord / iResolution.xy;
+    vec2 p  = uv * 2.0 - 1.0;
+
+    float sd   = sdfCircle(p, vec2(0.0), 0.5);
+    float blur = 0.01;
+
+    float edge = smoothstep(0.0, blur, sd); // soften around sd=0
+    fragColor  = vec4(vec3(1.0 - edge), 1.0);
+}
+```
+
+> **Why SDFs rock:** One formula gives you inside/outside, outlines, soft edges, morphing, boolean ops (union/intersection), glow, and more — all from distance.
+
+
+### Further reading
+- [Inigo Quilez — 2D distance functions](https://iquilezles.org/articles/distfunctions2d/)
+- [GLSL reference for length](https://registry.khronos.org/OpenGL-Refpages/gl4/html/length.xhtml)
+
+[Next: Part 6 — Aspect ratio](part06_aspect_ratio.md)
diff --git a/shaders/painting_with_math_sdf/part06_aspect_ratio.md b/shaders/painting_with_math_sdf/part06_aspect_ratio.md
new file mode 100644
index 0000000000000000000000000000000000000000..345236be6393f1bec3bb10641d1085f63843b65f
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part06_aspect_ratio.md
@@ -0,0 +1,30 @@
+---
+title: Part 6 — Aspect ratio
+---
+# {{ page.title }}
+
+**New concept:** Fix stretch from non-square viewports: scale x by `aspect = width/height`.
+
+**What changed:** Apply aspect to the *math* space `p`.
+
+```glsl
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv      = fragCoord / iResolution.xy;
+    vec2 p       = uv * 2.0 - 1.0;
+    float aspect = iResolution.x / iResolution.y;
+    p.x *= aspect; // prevent ellipse distortion
+
+    float sd   = length(p) - 0.5;
+    float edge = smoothstep(0.0, 0.01, sd);
+    fragColor  = vec4(vec3(1.0 - edge), 1.0);
+}
+```
+
+> **Math note:** This is a linear scaling in x; conceptually, you’re undoing the screen’s horizontal stretch in your compute space.
+
+
+### Further reading
+- [The Book of Shaders — Shapes](https://thebookofshaders.com/03/)
+- [Wikipedia — Aspect ratio](https://en.wikipedia.org/wiki/Aspect_ratio_(image))
+
+[Next: Part 7 — Combine shapes](part07_combine_shapes.md)
diff --git a/shaders/painting_with_math_sdf/part07_combine_shapes.md b/shaders/painting_with_math_sdf/part07_combine_shapes.md
new file mode 100644
index 0000000000000000000000000000000000000000..891af99e66e081578b77617b64f79a3549ae9ef9
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part07_combine_shapes.md
@@ -0,0 +1,37 @@
+---
+title: Part 7 — Combine shapes
+---
+# {{ page.title }}
+
+**New concept:** **Boolean ops** on SDFs:
+
+* Union: `min(sd1, sd2)`
+* Intersection: `max(sd1, sd2)`
+* Difference: `max(sd1, -sd2)`
+
+**What changed:** Two circles → union via `min`.
+
+```glsl
+float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }
+
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv      = fragCoord / iResolution.xy;
+    vec2 p       = uv * 2.0 - 1.0;
+    float aspect = iResolution.x / iResolution.y;
+    p.x *= aspect;
+
+    float sd1 = sdfCircle(p, vec2(-0.4, 0.0), 0.35);
+    float sd2 = sdfCircle(p, vec2( 0.4, 0.0), 0.35);
+
+    float sd   = min(sd1, sd2);           // union
+    float edge = smoothstep(0.0, 0.01, sd);
+    fragColor  = vec4(vec3(1.0 - edge), 1.0);
+}
+```
+
+
+### Further reading
+- [Inigo Quilez — Distance functions](https://iquilezles.org/articles/distfunctions/)
+- [GLSL reference for min/max](https://registry.khronos.org/OpenGL-Refpages/gl4/html/min.xhtml)
+
+[Next: Part 8 — Animation](part08_animation.md)
diff --git a/shaders/painting_with_math_sdf/part08_animation.md b/shaders/painting_with_math_sdf/part08_animation.md
new file mode 100644
index 0000000000000000000000000000000000000000..0bf0b2a8e76b4dd491e89f218e39c66eacf83102
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part08_animation.md
@@ -0,0 +1,38 @@
+---
+title: Part 8 — Animation
+---
+# {{ page.title }}
+
+**New concept:** Animate positions over time with sine/cosine.
+**Why:** `sin`/`cos` give smooth periodic motion (circles/ellipses/Lissajous).
+
+**What changed:** Circle centers move with time.
+
+```glsl
+float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }
+
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv      = fragCoord / iResolution.xy;
+    vec2 p       = uv * 2.0 - 1.0;
+    float aspect = iResolution.x / iResolution.y;
+    p.x *= aspect;
+
+    vec2 c1 = vec2(-0.3 + 0.25*cos(iTime*0.8),  0.20 + 0.20*sin(iTime*0.7));
+    vec2 c2 = vec2( 0.3 + 0.25*sin(iTime*0.9), -0.20 + 0.20*cos(iTime*0.6));
+
+    float sd = min(sdfCircle(p, c1, 0.35),
+                   sdfCircle(p, c2, 0.35));
+
+    float edge = smoothstep(0.0, 0.01, sd);
+    fragColor  = vec4(vec3(1.0 - edge), 1.0);
+}
+```
+
+> **Math note:** `(cos t, sin t)` traces a unit circle; scaling components gives ellipses; using different speeds/phases creates interesting paths.
+
+
+### Further reading
+- [The Book of Shaders — Time](https://thebookofshaders.com/07/)
+- [GLSL reference for sin and cos](https://registry.khronos.org/OpenGL-Refpages/gl4/html/sin.xhtml)
+
+[Next: Part 9 — Color mixing](part09_color_mixing.md)
diff --git a/shaders/painting_with_math_sdf/part09_color_mixing.md b/shaders/painting_with_math_sdf/part09_color_mixing.md
new file mode 100644
index 0000000000000000000000000000000000000000..4c5a12c317bf5d3d88788dc8c021729c9db27fa5
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part09_color_mixing.md
@@ -0,0 +1,47 @@
+---
+title: Part 9 — Color mixing
+---
+# {{ page.title }}
+
+**New concept:** Interpolate colors with `mix(a,b,t)` where `t∈[0,1]`.
+
+**What changed:** A background gradient + time-cycling tint on shapes.
+
+```glsl
+float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }
+
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv      = fragCoord / iResolution.xy;
+    vec2 p       = uv * 2.0 - 1.0;
+    float aspect = iResolution.x / iResolution.y;
+    p.x *= aspect;
+
+    vec2 c1 = vec2(-0.3 + 0.25*cos(iTime*0.8),  0.20 + 0.20*sin(iTime*0.7));
+    vec2 c2 = vec2( 0.3 + 0.25*sin(iTime*0.9), -0.20 + 0.20*cos(iTime*0.6));
+
+    float sd = min(sdfCircle(p, c1, 0.35),
+                   sdfCircle(p, c2, 0.35));
+
+    // Background gradient
+    vec3 bg  = mix(vec3(0.08,0.10,0.18), vec3(0.18,0.10,0.08), uv.x);
+
+    // Time-varying tint: phase-shifted sines for R,G,B
+    vec3 tint = 0.5 + 0.5 * vec3(
+        sin(iTime*0.6 + 0.0),
+        sin(iTime*0.6 + 2.1),
+        sin(iTime*0.6 + 4.2)
+    );
+
+    float edge = smoothstep(0.0, 0.01, sd);
+    vec3  col  = mix(bg, tint, 1.0 - edge); // draw shape over bg
+
+    fragColor = vec4(col, 1.0);
+}
+```
+
+
+### Further reading
+- [The Book of Shaders — Color](https://thebookofshaders.com/04/)
+- [GLSL reference for mix](https://registry.khronos.org/OpenGL-Refpages/gl4/html/mix.xhtml)
+
+[Next: Part 10 — Glow](part10_glow.md)
diff --git a/shaders/painting_with_math_sdf/part10_glow.md b/shaders/painting_with_math_sdf/part10_glow.md
new file mode 100644
index 0000000000000000000000000000000000000000..e6d03d2bb969a9e91c4e0a8984fa14df7e06c69f
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part10_glow.md
@@ -0,0 +1,55 @@
+---
+title: Part 10 — Glow
+---
+# {{ page.title }}
+
+**New concept:** Use SDF to build a **glow** via exponential falloff for `sd>0`.
+
+**What changed:** Add an additive halo based on positive distance.
+
+```glsl
+float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }
+
+float glowFromSDF(float sd, float strength, float tightness){
+    float g = exp(-tightness * max(sd, 0.0)); // decay outside the edge
+    return clamp(g * strength, 0.0, 1.0);
+}
+
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv      = fragCoord / iResolution.xy;
+    vec2 p       = uv * 2.0 - 1.0;
+    float aspect = iResolution.x / iResolution.y;
+    p.x *= aspect;
+
+    vec2 c1 = vec2(-0.3 + 0.25*cos(iTime*0.8),  0.20 + 0.20*sin(iTime*0.7));
+    vec2 c2 = vec2( 0.3 + 0.25*sin(iTime*0.9), -0.20 + 0.20*cos(iTime*0.6));
+
+    float sd1 = sdfCircle(p, c1, 0.35);
+    float sd2 = sdfCircle(p, c2, 0.35);
+    float sd  = min(sd1, sd2);
+
+    vec3 bg   = mix(vec3(0.06,0.06,0.10), vec3(0.13,0.10,0.08), uv.x);
+    vec3 tint = 0.5 + 0.5 * vec3(
+        sin(iTime*0.6 + 0.0),
+        sin(iTime*0.6 + 2.1),
+        sin(iTime*0.6 + 4.2)
+    );
+
+    float edge = smoothstep(0.0, 0.01, sd);
+    vec3  base = mix(bg, tint, 1.0 - edge);
+
+    float glow = glowFromSDF(sd, 0.9, 8.0);
+    vec3  col  = base + tint * glow * 0.6; // additive halo
+
+    fragColor = vec4(col, 1.0);
+}
+```
+
+> **Math note:** Exponential decay `e^{-k·sd}` gives a smooth halo whose width is controlled by `k` (“tightness”).
+
+
+### Further reading
+- [Inigo Quilez — Distance functions](https://iquilezles.org/articles/distfunctions/)
+- [GLSL reference for exp](https://registry.khronos.org/OpenGL-Refpages/gl4/html/exp.xhtml)
+
+[Next: Part 11 — Smooth union](part11_smooth_union.md)
diff --git a/shaders/painting_with_math_sdf/part11_smooth_union.md b/shaders/painting_with_math_sdf/part11_smooth_union.md
new file mode 100644
index 0000000000000000000000000000000000000000..5f09ba6021ab15e52bc92e38ae36538dda902f85
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part11_smooth_union.md
@@ -0,0 +1,32 @@
+---
+title: Part 11 — Smooth union
+---
+# {{ page.title }}
+
+**New concept:** Replace sharp `min` with **smooth min `smin`** to blend shapes organically.
+Parameter `k` controls softness (larger = softer).
+
+**What changed:** Use `smin` when combining SDFs.
+
+```glsl
+float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }
+
+// Smooth min blend (IQ-style)
+float smin(float a, float b, float k){
+    float h = clamp(0.5 + 0.5*(b - a)/k, 0.0, 1.0);
+    return mix(b, a, h) - k*h*(1.0 - h);
+}
+```
+
+Use it instead of `min(sd1, sd2)`:
+
+```glsl
+float sd = smin(sd1, sd2, 0.25); // try k in [0.05 .. 0.5]
+```
+
+
+### Further reading
+- [Inigo Quilez — Smooth minimum](https://iquilezles.org/articles/smin/)
+- [GLSL reference for mix](https://registry.khronos.org/OpenGL-Refpages/gl4/html/mix.xhtml)
+
+[Next: Part 12 — Interactivity](part12_interactivity.md)
diff --git a/shaders/painting_with_math_sdf/part12_interactivity.md b/shaders/painting_with_math_sdf/part12_interactivity.md
new file mode 100644
index 0000000000000000000000000000000000000000..10a248235df1c7628aab92fcbc11a3b817e5d19e
--- /dev/null
+++ b/shaders/painting_with_math_sdf/part12_interactivity.md
@@ -0,0 +1,40 @@
+---
+title: Part 12 — Interactivity
+---
+# {{ page.title }}
+
+**New concept:** Use `iMouse.xy` to control a shape.
+**What changed:** Convert mouse pixels → UV → centered → aspect-corrected.
+
+```glsl
+float sdfCircle(vec2 p, vec2 c, float r){ return length(p - c) - r; }
+
+void mainImage(out vec4 fragColor, in vec2 fragCoord) {
+    vec2 uv      = fragCoord / iResolution.xy;
+    vec2 p       = uv * 2.0 - 1.0;
+    float aspect = iResolution.x / iResolution.y;
+    p.x *= aspect;
+
+    // If mouse is down (iMouse.z>0), place circle at mouse; else center
+    vec2 muv = iMouse.z > 0.0 ? (iMouse.xy / iResolution.xy) : vec2(0.5);
+    vec2 mc  = muv * 2.0 - 1.0;
+    mc.x *= aspect;
+
+    float sd   = sdfCircle(p, mc, 0.3);
+    float edge = smoothstep(0.0, 0.01, sd);
+
+    vec3 bg  = vec3(0.05,0.07,0.10);
+    vec3 ink = vec3(0.85,0.65,0.30);
+
+    vec3 col = mix(bg, ink, 1.0 - edge);
+    fragColor = vec4(col, 1.0);
+}
+```
+
+
+
+### Further reading
+- [The Book of Shaders — Uniforms](https://thebookofshaders.com/02/)
+- [Shadertoy docs — iMouse](https://www.shadertoy.com/howto)
+
+[Back to workshop overview](index.md)
 
EOF
)
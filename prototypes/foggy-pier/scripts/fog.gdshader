shader_type canvas_item;
// Drifting volumetric-ish fog for a full-screen ColorRect.
// Self-contained: generates its own fbm noise, so it needs no noise texture.
// Tweak the uniforms live in the Inspector (ColorRect > Material) to taste.

uniform vec4 fog_color : source_color = vec4(0.62, 0.66, 0.72, 1.0);
uniform float density : hint_range(0.0, 1.0) = 0.55;
uniform float scroll_speed = 0.02;
uniform float scale = 3.0;
// Edge darkening that pushes the cozy scene toward unease.
uniform float vignette : hint_range(0.0, 1.0) = 0.35;

float hash(vec2 p) {
	p = fract(p * vec2(123.34, 345.45));
	p += dot(p, p + 34.345);
	return fract(p.x * p.y);
}

float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	f = f * f * (3.0 - 2.0 * f);
	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));
	return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

float fbm(vec2 p) {
	float v = 0.0;
	float amp = 0.5;
	for (int i = 0; i < 5; i++) {
		v += amp * noise(p);
		p *= 2.0;
		amp *= 0.5;
	}
	return v;
}

void fragment() {
	vec2 uv = UV * scale;
	float t = TIME * scroll_speed;

	// Domain-warp the noise by itself so the fog roils instead of sliding.
	float n = fbm(uv + vec2(t, t * 0.5));
	n = fbm(uv + vec2(n * 1.5) + vec2(-t * 0.5, t));

	float fog_alpha = smoothstep(0.2, 0.9, n) * density;

	// Radial vignette: 0 at center, up to `vignette` opaque-dark at corners.
	vec2 d = UV - vec2(0.5);
	float vig = smoothstep(0.25, 0.75, length(d)) * vignette;

	// Composite fog over the scene, then darken the edges.
	vec3 col = fog_color.rgb;
	float a = fog_alpha + vig;
	// Bias colour toward black where the vignette dominates.
	col = mix(col, vec3(0.02, 0.03, 0.05), clamp(vig / max(a, 0.001), 0.0, 1.0));

	COLOR = vec4(col, clamp(a, 0.0, 1.0));
}

shader_type canvas_item;

uniform vec4 outline_color_min : source_color = vec4(0.28, 0.23, 0.52, 0.0);
uniform vec4 outline_color_max : source_color = vec4(0.14, 0.10, 0.27, 1.0);
uniform float fade_time = 4.0;
uniform bool do_blinking = true;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 up = vec2(0, TEXTURE_PIXEL_SIZE.y);
	vec2 right = vec2(TEXTURE_PIXEL_SIZE.x, 0);
	
	vec4 outline = vec4(1.0, 1.0, 1.0, 0.0);
	outline += vec4(1.0, 1.0, 1.0, texture(TEXTURE, UV - up).a);
	outline += vec4(1.0, 1.0, 1.0, texture(TEXTURE, UV + up).a);
	outline += vec4(1.0, 1.0, 1.0, texture(TEXTURE, UV - right).a);
	outline += vec4(1.0, 1.0, 1.0, texture(TEXTURE, UV + right).a);

	outline *= 1. - texture(TEXTURE, UV).a;
	outline = clamp(outline, 0.0, 1.0);
	
	float t = 0.5 * (1.0 + cos(2.0 * PI * TIME / fade_time));
	outline *= mix(outline_color_min, outline_color_max, t);
	outline.a *= float(do_blinking);
	
	COLOR = texture(TEXTURE, UV) * texture(TEXTURE, UV).a;
	COLOR += outline;
}

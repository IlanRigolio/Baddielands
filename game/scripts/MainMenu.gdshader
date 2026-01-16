shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D hair_noise : repeat_enable, filter_linear_mipmap;

// --- NOUVEAU : VIGNETTE ---
// Plus c'est haut, plus les coins sont sombres.
// 0.5 = subtil, 1.5 = très marqué.
uniform float vignette_strength : hint_range(0.0, 2.0) = 0.8;

// --- REGLAGES CHEVEUX ---
uniform vec4 hair_color : source_color = vec4(1.0, 0.98, 0.90, 0.8);
uniform float hair_thickness : hint_range(0.001, 0.05) = 0.008;
uniform float hair_threshold : hint_range(0.0, 1.0) = 0.5;
uniform float hair_len : hint_range(0.05, 1.0) = 0.3;

// --- VITESSE ---
uniform float jump_speed : hint_range(1.0, 60.0) = 10.0;
uniform float vibration_speed : hint_range(0.0, 100.0) = 50.0;
uniform float vibration_amt : hint_range(0.0, 0.01) = 0.002;

// --- FORME ---
uniform float curve_strength : hint_range(0.0, 0.2) = 0.05;
uniform float curve_frequency : hint_range(1.0, 20.0) = 5.0;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
	vec4 text = texture(screen_texture, SCREEN_UV);
	vec2 uv = SCREEN_UV;

	// --- PARTIE 1 : LES CHEVEUX (Ton réglage parfait) ---
	float time_jump = floor(TIME * jump_speed);
	float random_x = rand(vec2(time_jump, 0.0)) * 10.0;
	float random_y_center = rand(vec2(0.0, time_jump));
	vec2 shake = vec2(sin(TIME * vibration_speed) * vibration_amt, 0.0);

	float curve = sin(uv.y * curve_frequency + random_x * 10.0) * curve_strength;

	float noise_val = texture(hair_noise, vec2(uv.x + curve + random_x + shake.x, 0.5)).r;

	float distance_to_threshold = abs(noise_val - hair_threshold);
	float hair_mask = 1.0 - smoothstep(0.0, hair_thickness, distance_to_threshold);

	float dist_from_center_hair = abs(uv.y - random_y_center);
	float length_mask = 1.0 - smoothstep(hair_len * 0.4, hair_len * 0.5, dist_from_center_hair);

	hair_mask *= length_mask;

	// Application des cheveux sur l'image
	text.rgb = mix(text.rgb, hair_color.rgb, hair_mask * hair_color.a);

	// --- PARTIE 2 : LA VIGNETTE (Nouveau !) ---
	// On calcule la distance du pixel par rapport au centre de l'écran (0.5, 0.5)
	float dist_from_screen_center = distance(uv, vec2(0.5));
	// On assombrit l'image finale (cheveux inclus) en fonction de cette distance
	text.rgb *= (1.0 - dist_from_screen_center * vignette_strength);

	COLOR = text;
}
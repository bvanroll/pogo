shader_type spatial;

uniform float u_time;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 st = FRAGCOORD.xy;
	float r = sin(st.x * .003 + TIME);
	float g = sin(st.y * .003 + TIME);
	float b = cos(r/g);
	
	ALBEDO = vec3(r, g, b);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

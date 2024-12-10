shader_type canvas_item;
uniform sampler2D noise1;
uniform sampler2D noise2;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float n1 = texture(noise1, UV).r;
	float n2 = texture(noise2, UV).r;
	float color = n1 * 0.5 + n2 * 1.0;
	COLOR = vec4(1.0 - color ,1.0 - color, 1.0 - color,1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

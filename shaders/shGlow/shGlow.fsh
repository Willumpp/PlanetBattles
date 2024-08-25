//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float texW;
uniform float texH;

void main()
{
	vec2 offsetx;
	offsetx.x = texW;
	
	vec2 offsety;
	offsety.y = texH;
	
	//Blur should be an average of the surrounding colours
	vec4 sum;
	vec4 threshhold = vec4(0., 0., 0., 0.);
	float total;
	int size = 25 / 2;
	/*
	for (int i = -size; i < size; i++) {
		for (int j = -size; j < size; j++) {
			vec4 col = texture2D( gm_BaseTexture, v_vTexcoord + offsetx*float(i) + offsety*float(j) );
			if (col == vec4(0., 0., 0., 0.)) { continue; }
			if (col != vec4(0., 0., 0., 0.)) {
				total += 1.;
				sum += col;
			}
		}
	}
	*/
	//Faster, less attractive way
	//	perform two 1D blurs
	for (int i = -size; i < size; i++) {
		vec4 col = texture2D( gm_BaseTexture, v_vTexcoord + offsetx*float(i) );
		
		if ( col == threshhold) { continue; }
		total += 1.;
		sum += col;
	}
	for (int i = -size; i < size; i++) {
		vec4 col = texture2D( gm_BaseTexture, v_vTexcoord + offsety*float(i) );
		
		if (col == threshhold) { continue; }
		total += 1.;
		sum += col;
	}
	
	//The blur on top should hopefully give a glow effect
	sum = sum / total;
	vec4 orig = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 avg = (sum + orig) / 2.;
	
    gl_FragColor = v_vColour * (avg + texture2D( gm_BaseTexture, v_vTexcoord ));
}

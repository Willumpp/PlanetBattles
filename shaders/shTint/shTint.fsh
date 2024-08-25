//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 threshhold = vec4(0., 0., 0., 0.);
	vec4 col = vec4(0.5, 0.25, 0.5, 0.0);
	if ( length(texture2D( gm_BaseTexture, v_vTexcoord )) <= 0.9) { col = vec4(0., 0., 0., 0.); }
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ) + col;
}

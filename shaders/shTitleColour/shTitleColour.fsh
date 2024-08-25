//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 colour;
uniform float texW;
uniform float texH;

void main()
{
	//Blend the colours
	vec4 col = texture2D( gm_BaseTexture, v_vTexcoord );
	col = col - vec4(1.-colour.r, 1.-colour.g, 1.-colour.b, 0.)*0.9;
    gl_FragColor = v_vColour * col;
}

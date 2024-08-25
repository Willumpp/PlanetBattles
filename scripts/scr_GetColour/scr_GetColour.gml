// Converts the ship type to a clour to blen
function scr_GetColour(type){
	switch (type) {
		case st.red: return c_red;
		case st.green: return c_green;
		case st.blue: return c_blue
		default: return c_red;
	}
}
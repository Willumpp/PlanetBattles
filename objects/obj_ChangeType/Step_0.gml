
//Change ship type of selected ship
if scr_ButtonPress() {
	
	//Increment and clamp
	global.ship_type1 += 1
	if global.ship_type1 > st.blue {	
		global.ship_type1 = st.red
	}
	
	ship_display.change_type(global.ship_type1)
}
function change_type(type) {
	switch (type) {
		case st.red:
			ship_type = spr_Player1;
			break;
		case st.green:
			ship_type = spr_Player2;
			break;
		case st.blue:
			ship_type = spr_Player3;
			break;
	}
}
ship_type = spr_Player1
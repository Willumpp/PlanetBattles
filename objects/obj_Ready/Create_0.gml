//Ready - multiplayer only
//this can be a voting system to vote the game to start
//this object is deleted by "obj_Lobby"
has_voted = false;
votes = 0;

function reset_votes() {
	votes = 0;
	has_voted = false;
}

//Adds a vote "n"
//	sends message to server
function vote(n) {

	//send vote information
	with (obj_Player) {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.ready_vote);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		buffer_write(client_buffer, buffer_s8, n); //how much to increment the vote 

		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
}

draw_set_font(fnt_Nasalization12);
draw_set_halign(fa_center);
image_xscale = string_width("Vote Ready: 0")/64
image_yscale = string_height("Vote Ready: 0")/64;

x = view_wport[0]/2 - 26+24;
y = view_hport[0]/2 + 148;
/*
draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_right);

//Loop through all the option keys
var spacing  = (view_hport[0]/2)/(oplen)


var ioption = 0;
var ihost = 0;
for (var i = 0; i < oplen; i++) {
	//Draw the text of all the options
	if moptions[? loptions[i]][? "type"] == "game" {
		
		draw_text(view_wport[0]/2 - 128*global.scscale, spacing * ioption + (view_hport[0]/2+128*global.scscale), loptions[i]);
		ioption++
	}
	else {
		draw_text(view_wport[0]/2 - 128*global.scscale, spacing * ihost + 128*global.scscale, loptions[i]);
		ihost++
	}	
}


draw_set_font(global.fntsize3);
draw_set_halign(fa_center);
draw_text(view_wport[0]/2, (view_hport[0]/2), "Client Settings:")
*/

//draw_roundrect(view_wport[0]/2 - (256*global.scscale+string_width(longest_text)), (128-64)*global.scscale, 
//			   view_wport[0]/2 + (256*global.scscale+string_width(longest_text)), spacing * ihost + (view_hport[0]/2), true)

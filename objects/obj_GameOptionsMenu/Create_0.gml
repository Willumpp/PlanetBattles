//My idea is to have list of options
//	this would include [name, option_selected, [display values], [values]]
//	"display values" represents the values the use would see when changing options
//	"values" represents the value the game would use for processing


/*
options = @'
{
	"Resolution": {
		"selected":0,
		"display":["1920x1080", "1280x720"],
		"values":[[1920, 1080], [1280, 720]]
	}
}

'
var out = json_decode(options);
scr_SaveJSON(out);
*/


moptions = global.moptions
global.options_changed = false;
loptions = ds_map_keys_to_array(moptions); //Get a list of the key
oplen = array_length(loptions);

//This buffer will be used to send the options of the game to the clients
//	everything should hopefully as result be in sync
//	buffer starts with number of options
//	this is followed by the option name and the selected type
options_buffer = buffer_create(1024, buffer_fixed, 1);
buffer_seek(options_buffer, buffer_seek_start, 0);

//placeholder:, "Unlimited Ammo": { "values": [ 0.000000, 1.000000 ], "display": [ "OFF", "ON" ], "selected": 0.000000, "type": "ship" }

//Apply loaded options
var ioption = 0;
var ihost = 0;

for (var i = 0; i < oplen; i++) {
	//var _option_name = loptions[i];
	//var _selected = moptions[? loptions[i]][? "selected"]
	
	//Count the total amount of game options
	if moptions[? loptions[i]][? "type"] == "ship" {
		ihost++; //This will be used to tell the buffer size
	}	
		
	//scr_ApplyOption(_option_name, _selected)
}

buffer_write(options_buffer, buffer_u8, network.apply_options); //msgid
buffer_write(options_buffer, buffer_u8, network.toclient); //destination type
buffer_write(options_buffer, buffer_u8, ihost); //Write the number of options so the client knows what to expect

//Create option selections
//Loop through all the option keys
//var spacing  = (view_hport[0]/2)/(oplen)
var spacing  = (view_hport[0])/(oplen)
ioption = 0;
ihost = 0;
//Catergories
//c="catergory"
var cmap = ds_list_create();
var cplayers = ds_list_create();
var cevents = ds_list_create();
coffset = 48;
cspacing = view_hport[0]/(3*global.scscale);
instance_create_layer(view_wport[0]/2, coffset*global.scscale*0.3, "GameOptions", obj_OpSubtitle).text = "Map"
instance_create_layer(view_wport[0]/2, (cspacing+ coffset*0.3)*global.scscale, "GameOptions", obj_OpSubtitle).text = "Players"
instance_create_layer(view_wport[0]/2, (cspacing*2 + coffset*0.3 )*global.scscale, "GameOptions", obj_OpSubtitle).text = "Events"

for (var i = 0; i < oplen; i++) {
	

	//Draw the text of all the options
	if moptions[? loptions[i]][? "type"] == "game" {
		//var _obj = instance_create_layer(view_wport[0]/2 +128*global.scscale, spacing * ioption + (view_hport[0]/2+128*global.scscale), "Options", obj_Option)
		var _obj = instance_create_layer(view_wport[0]/2 +128*global.scscale, spacing * ioption + 128*global.scscale, "Options", obj_Option)
		ioption++
	}
	else if moptions[? loptions[i]][? "type"] == "ship" {
		var _cat = moptions[? loptions[i]][? "category"];
		var _clist;
		var _off = coffset;
		
		switch (_cat) {
			case "Map":
				_clist = cmap;
				break;
			case "Players":
				_clist = cplayers;
				_off += cspacing;
				break;
			case "Events":
				_clist = cevents;
				_off += 2*cspacing
				break;
		}
		
		var _obj = instance_create_layer(view_wport[0]/2 +128*global.scscale, spacing*ds_list_size(_clist) + _off*global.scscale, "GameOptions", obj_Option)
		ihost++;
		
		ds_list_add(_clist, _obj);
		
		
		//Clients option name and selected
		buffer_write(options_buffer, buffer_string, loptions[i]);
		buffer_write(options_buffer, buffer_u8, moptions[? loptions[i]][? "selected"]); //Selected option of name
	}	
	
	if moptions[? loptions[i]][? "type"] != "hidden" {
		_obj.option_name = loptions[i];
		_obj.selected = moptions[? loptions[i]][? "selected"]
		_obj.values = moptions[? loptions[i]][? "values"]
		_obj.display = moptions[? loptions[i]][? "display"]
	}
}

ds_list_destroy(cmap)
ds_list_destroy(cplayers)
ds_list_destroy(cevents)

global.opbuffer = options_buffer; //buffer of all options (including seed)
global.opbuffersize = buffer_tell(options_buffer);

//Controls what the sequence of options go through
//	I am re-using layers for the game options and edit ship
//	this controls where to go after edit ship
play_mode = "JoinGame"
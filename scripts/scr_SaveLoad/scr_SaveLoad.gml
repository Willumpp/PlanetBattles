
function scr_SaveJSON(fname, map) {
	var out = json_encode(map); //Returns string version of map

	//write buffer to file
	var _buffer = buffer_create(string_byte_length(out)+1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, out);
	buffer_save(_buffer, fname);
	buffer_delete(_buffer);
}


//load json
//	return map
function scr_LoadJSON(fname, def) {
	//Create the options file if it doesnt already exist
	//	write default options to it
	if file_exists(fname) == false {
		
		var _str = def;
		var _buff = buffer_create(string_byte_length(_str)+1, buffer_fixed, 1);
		buffer_write(_buff, buffer_string, _str);
		buffer_save(_buff, fname);
		buffer_delete(_buff);
	}
	
	//Load the file into a buffer
	var _buffer = buffer_load(fname);
	var str = buffer_read(_buffer, buffer_string);
	var out = json_decode(str); //Convert string to a map
	
	buffer_delete(_buffer);
	return out;
	
}

function scr_FocusLayer(focus_layer){
	
	//Deactivate all layers except asteroids, background, and the layer in focus
	for (var i = 0; i < array_length(layer_get_all()); i++) {
		layer_id = layer_get_all()[i] //Get layer id
		
		//Ignore important layers
		if layer_id != layer_get_id("Asteroids") and layer_id != layer_get_id("Background") 
			 and layer_id != layer_get_id("IntroSequence") and layer_id != layer_get_id(focus_layer) {
				
			//Hide and deactivate all instances
			instance_deactivate_layer(layer_id)
			layer_set_visible(layer_id, false)
		}
	}
	
	//Enable wanted layer
	layer_set_visible(focus_layer, true);
	instance_activate_layer(focus_layer);
}
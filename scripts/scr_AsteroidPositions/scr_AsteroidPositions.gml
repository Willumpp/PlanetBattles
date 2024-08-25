// Asteroid generation
//	Randomly chooses an angle from 0 to 360/total points
//		offset by an about based on iteration
//	create a point at that angle from the latest point (from a given scale)
//	this repeats x times and then connects the end to the start
//Returns the queue of positions
function scr_AsteroidPositions(total_points, scale){
	var turn_angle = 360/total_points;
	
	var pos = ds_queue_create(); //Queue of all positions to join for asteroid shape
	ds_queue_enqueue(pos, [x, y]);// The starting position of the shape draw
	
	var centre = [0,0]; //Will be the middle of all the points, this will become the centre of rotation
	var pos_totals = [0,0]; //Will be used to take an average for the centre
	
	//Repeat x number of turns
	for (var i = 0; i < total_points-1; i++) {
		var _pos = ds_queue_tail(pos); //Position on the end of the queue to branch from
		var _new_pos = [];
		
		//Get random angle to make a branch from position
		turn = irandom_range(0,turn_angle) + i*turn_angle;
		//Get x and y components of the branch to add to the last position
		x_comp = scale * cos(turn*pi/180);
		y_comp = scale * sin(turn*pi/180);
		
		//The new position from the last
		_new_pos = [_pos[0] + x_comp, _pos[1] + y_comp];
		ds_queue_enqueue(pos, _new_pos);
		
		pos_totals[0] += _new_pos[0]
		pos_totals[1] += _new_pos[1]
		
	}
	ds_queue_enqueue(pos, [x, y]); //Add first position again to connect line to start
	
	centre = [pos_totals[0]/(ds_queue_size(pos)-2), 
			  pos_totals[1]/(ds_queue_size(pos)-2)] //Calculate average of all positions to find centre
	return [pos, centre] //queue of positions, centre of all positions
}
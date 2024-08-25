//Connect positions
//"_pos_queue" will be a copy of the original queue
//	this is so the draw event can repeatingly copy the original as queues remove elements
ds_queue_clear(_pos_queue)
ds_queue_copy(_pos_queue, pos);

//This is so the final point can connect back to the start
var last = scr_RotatePoint(ds_queue_head(_pos_queue), angle, centre);

//This is for only drawing and rotating when on camera
if perform_calcs == true {
	//Start the draw
	draw_primitive_begin(pr_linestrip);
	for (var i = 0; i < ds_queue_size(pos)-1; i++) {
		//Get the first position in the queue
		var _pos = ds_queue_dequeue(_pos_queue);
	
		//Apply the rotation of the point
		//	applies matrix maths etc. 
		//	possibly ineffiecient?
		//returns the transformed point
		_pos = scr_RotatePoint(_pos, angle, centre)
	
		//Draw the new point
		draw_vertex(_pos[0] + offset[0], _pos[1] + offset[1]);
	}
	//Connect back to the start
	draw_vertex(last[0] + offset[0], last[1] + offset[1]);
	draw_primitive_end(); //End draw
}

angle += 1; //Rotate by x degrees
offset[0] += velocity[0];
offset[1] += velocity[1];
x = offset[0] + centre[0];
y = offset[1] + centre[1];
//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true) //draw collision box

//Destroy if out of screen

if last[0] + offset[0] > room_width + delete_border or last[0] + offset[0] < -delete_border 
		or last[1] + offset[1] > room_height + delete_border or last[1] + offset[1] < -delete_border {
	instance_destroy(id);
}
draw_set_color(c_white)
//parCreate(global.parSys, x, y, parTypePoint, 1);

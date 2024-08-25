function parCreate(system, xpos, ypos, type, count) {
	if global.enableparticles {
		part_particles_create(system, xpos, ypos, type, count);
	}
}

function parSelfTrail(type, alpha, sprite) {
	part_type_clear(type)
	part_type_life(type, room_speed/4, room_speed/4);
	part_type_sprite(type, sprite, 0, 0, false);
	part_type_alpha2(type, alpha, 0);
	part_type_direction(type, image_angle, image_angle, 0, 0);
	part_type_orientation(type, image_angle, image_angle, 0, 0, 0);
}

function parFire(type) {
	
	part_type_life(type, room_speed*0.1, room_speed*0.1);
	part_type_shape(type, pt_shape_square);
	part_type_scale(type, 1,1);
	part_type_size(type, 0.10,0.15,-.001,0);
	part_type_alpha2(type, 0.5, 0);
	part_type_color2(type,8454143,65280);
	part_type_alpha2(type,1,0.75);
	part_type_speed(type,1,5,0,0);
	part_type_direction(type,0,359,0,0);
	part_type_orientation(type,0,359,10,0,true);
	part_type_blend(type,true);
	
}


function parPew(type, colour, angle, scale, life) {
	part_type_life(type, room_speed*life, room_speed*life);
	part_type_alpha2(type, 0.5, 0);
	part_type_color1(type, colour);
	part_type_shape(type, pt_shape_disk);
	part_type_scale(type, scale, scale)
	//part_type_orientation(type, image_angle-30, image_angle+30, 0, 0, true);
	part_type_direction(type, angle-30, angle+30, 0, 0);
	part_type_speed(type, 5, 10, -0.20, 0);

}

function parStream(type, colourf, colourt, angle, scale, life, spd) {
	part_type_life(type, room_speed*life, room_speed*life);
	part_type_alpha2(type, 0.5, 0);
	//part_type_color1(type, colour);
	part_type_color2(type,colourf,colourt);
	part_type_shape(type, pt_shape_disk);
	part_type_scale(type, scale, scale)
	//part_type_orientation(type, image_angle-30, image_angle+30, 0, 0, true);
	part_type_direction(type, angle, angle, 0, 0);
	part_type_speed(type, spd, spd, -0.20, 0);

}

function parLaunch(type, colour, angle, scale, life, spd) {
	part_type_life(type, room_speed*life, room_speed*life);
	part_type_alpha2(type, 0.5, 0);
	part_type_color1(type, colour);
	part_type_shape(type, pt_shape_disk);
	part_type_scale(type, scale, scale)
	//part_type_orientation(type, image_angle-30, image_angle+30, 0, 0, true);
	part_type_direction(type, angle-30, angle+30, 0, 0);
	part_type_speed(type, spd/2, spd, -0.20, 0);

}

function parExplode(type, colour, scale, life, spd) {
	part_type_life(type, room_speed*life, room_speed*life);
	part_type_alpha2(type, 0.5, 0);
	part_type_color1(type, colour);
	part_type_shape(type, pt_shape_square);
	part_type_scale(type, scale, scale)
	//part_type_orientation(type, image_angle-30, image_angle+30, 0, 0, true);
	part_type_direction(type, 0, 360, 0, 0);
	part_type_speed(type, spd/2, spd, -0.20, 0);
}

function parPoint(type, scale) {
	part_type_life(type, room_speed/2, room_speed/2);
	part_type_alpha2(type, 0.1, 0);
	part_type_shape(type, pt_shape_disk);
	part_type_size(type, scale, scale, -0.01, 0);
}

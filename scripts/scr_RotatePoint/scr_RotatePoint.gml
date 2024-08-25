// Rotates a point on 2d plane around a centre by a given angle
function scr_RotatePoint(point, angle, centre){
	
	//Rotation matrix
	var radian = angle*pi/180;
	rotate_matrix = [[cos(radian), -sin(radian)], [sin(radian), cos(radian)]];

	//Translate to origin
	point = [point[0] - centre[0], point[1] - centre[1]];
	
	//Rotate
	point = [rotate_matrix[0][0] * point[0] + rotate_matrix[0][1] * point[1],
			rotate_matrix[1][0] * point[0] + rotate_matrix[1][1] * point[1]];
			
	//Translate back to original position
	point = [point[0] + centre[0], point[1] + centre[1]];
	
	return point
}
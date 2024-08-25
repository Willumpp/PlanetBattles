//This creates a shield of orbiting asteroids
player = undefined;
asteroid_n = 10;
asteroids_dead = 0;

//Create the asteroids at intervals
for (var i = 0; i < 360; i+=360/asteroid_n) {
	var asteroid = instance_create_layer(x, y, "Players", obj_Miniasteroid);
	asteroid.angle = i;
	asteroid.parent = id;
}
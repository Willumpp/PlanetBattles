function scr_GenerateAmmoPack(xpos, ypos, ammo_quantity){
	var _pack = instance_create_layer(xpos, ypos, "Players", obj_AmmoPack);
	_pack.quantity = ammo_quantity;
}
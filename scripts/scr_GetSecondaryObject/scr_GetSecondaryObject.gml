//Converts senum to function
function scr_GetSecondaryObject(sec_num) {
	switch (sec_num) {
		case secondary.homingbullet:
			return obj_HomingBullet;
		case secondary.homingbarrage:
			return obj_HomingBarrage;
		case secondary.shield:
			return obj_Shield;
		case secondary.shockwave:
			return obj_Shockwave;
		case secondary.lifedrain:
			return obj_Lifedrain;
		case secondary.laser:
			return obj_Laser;
		case secondary.bouncearmada:
			return obj_BounceArmada;
		case secondary.destroyshield:
			return obj_Shield
		case secondary.astershield:
			return obj_Astershield
		case secondary.missile:
			return obj_MissileBarrage
		case secondary.energyspray:
			return obj_EnergySpray
		case secondary.null:
			return scr_Blank
		default:
			return scr_Blank;
	}

}
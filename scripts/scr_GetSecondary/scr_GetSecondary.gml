//Converts senum to function
function scr_GetSecondary(sec_num) {
	switch (sec_num) {
		case secondary.homingbullet:
			return scr_HomingBullet;
		case secondary.homingbarrage:
			return scr_HomingBulletBarrage;
		case secondary.shield:
			return scr_Shield;
		case secondary.shockwave:
			return scr_PlayerShockwave;
		case secondary.lifedrain:
			return scr_Lifedrain;
		case secondary.laser:
			return scr_BigLaser;
		case secondary.bouncearmada:
			return scr_BounceArmada;
		case secondary.energyspray:
			return scr_EnergySpray;
		case secondary.destroyshield:
			return scr_DestroyShield
		case secondary.astershield:
			return scr_Astershield
		case secondary.missile:
			return scr_Missile
		case secondary.null:
			return scr_Blank
		default:
			return scr_Blank;
	}

}
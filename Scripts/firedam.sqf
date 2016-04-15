// by ALIAS
// damage inflicted by fire

	_d = 0.01;
	
	while {fireexpunere} do {
		enableCamShake true;
		addCamShake [5, 1, 17];
		_d=_d+0.02;
		player setdammage _d;
		playsound "burned";
		sleep 2.5+random 1;	
		enableCamShake false;
	};
	

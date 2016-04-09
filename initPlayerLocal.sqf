ExileClientMoonLight = "#lightpoint" createVehicleLocal [0, 0, 0];
ExileClientMoonLight setLightAttenuation [10e10, 150, 4.31918e-005, 4.31918e-005];
ExileClientMoonLight setLightAmbient [63/255, 102/255, 155/255];
ExileClientMoonLight setLightBrightness 0.40;
ExileClientMoonLight setLightDayLight false;

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

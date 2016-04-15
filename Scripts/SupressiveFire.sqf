/*

	Suppressive Fire Example

	Author: Big_Wilk

	Description: Forces units or vehicles including static weapons to fire randomly at passed world positions.

	Parmas:
	0: ARRAY: of Object; Can be any of the following:
		Vehicle - "gunner" fires only
		Units - Variable containing a unit.
		Group - All units in the group fire
	1: ARRAY: of Potion; Can be any of the following:
		ARRAY - position in format [x,y] or [x,y,z]
		OBJECT - object
		GROUP - group leader
		LOCATION - location
		STRING - marker
	2: NUMBER: The time the units will fire for in seconds. Default 60 seconds.
	3: NUMBER: Max time between units fireing. Default 0.1.
	4: BOOL: Give vehicles full ammo before firing and top up units magazines? (true / false) If they run out of ammo they will not fire. Default true (units will not reload of true).

	Example 1:
	0 = [ [gun1, gun2, group1], [[100,102,0],"marker1",Car1] ] execVM "SupressiveFire.sqf";
	Result: gun1, gun2 and all units in a group named group1 will fire at "marker1" and car1 for 60 seconds.

	Example 2:
	0 = [ [myVehicle,car1,man1], ["marker1","marker2","marker3","marker4",car2], 120, .1, true ] execVM "SupressiveFire.sqf";
	Result: myVehicle, car1 and man1 will fire at "marker1" to "marker3" and car2 for 120 seconds, each will be rearmed before firing.

	Example 3:
	0 = [ [veh1,veh2,veh3,u1,u2,u3,u4,u5,u6,g1,g2,group1], ["marker_0","marker_1","marker_2","marker_3","marker_4","marker_5"], 60, .1, false ] execVM "SupressiveFire.sqf";
	Result: The vehs groups and units list will fire at markers 0-5 for 60 seconds and wont be armed, if they run out of ammo they will stop firing.

*/

private ["_arrayOfUnits","_arrayOfVehicles"];

// Parmas
_gunnerArray = _this param [0, [],[[]]];
_posArray = _this param [1, [],[[]]];
_forSeconds = _this param [2, 60, [60]];
_sleepTime = _this param [3, .1, [.1]];
_rearm = _this param [4, true, [true]];

if ( count _gunnerArray == 0 or count _posArray == 0) exitWith { systemChat "No input for SupressiveFire.sqf"; };

// Covert Pos array into real pos
_allPos = [];
{
	if !(isNil "_x") then {
		_posX = _x call BIS_fnc_position;
		if (str _posX != "[0,0,0]") then {
			_allPos pushBack _posX;
		};
	};
} forEach _posArray;

// Split Units and vehicles;
_arrayOfUnits = [];
_arrayOfVehicles = [];
{
	private "_unit";
	_unit = _x;
	switch (typeName _unit) do {
		case "GROUP": {
			{
				if (_x isKindOf "man") then {
					_arrayOfUnits pushBack _x;
				} else {
					_arrayOfVehicles pushBack _x;
				};
			} forEach units _unit;
		};
		case "OBJECT": {
			if (_unit isKindOf "man") then {
				_arrayOfUnits pushBack _unit;
			} else {
				_arrayOfVehicles pushBack _unit;
			};
		};
	};
} forEach _gunnerArray;

// Set combat mode of units:
{
	_x setBehaviour "combat";
	_unit = _x;
	{_unit reveal _x;} forEach allUnits;
	//_x suppressFor _forSeconds;
} forEach _arrayOfUnits;

{
	_x setVehicleAmmo 1;
} forEach _arrayOfVehicles;

sleep 0.5;

// Fire the weapons for time passed:
_endTime = time + _forSeconds;
While {time < _endTime} do {

	{

		{
			if (alive _x) then {
				if _rearm then {
					_x setAmmo [primaryWeapon _x, 1000];
				};
				_x doWatch (_allPos call BIS_fnc_selectRandom);
				sleep random _sleepTime;
				_x forceWeaponFire [(primaryWeapon _x), "ACE_Burst_far"];
			} else {
				_arrayOfUnits = _arrayOfUnits - [_x];
			};
		} forEach _arrayOfUnits;

		{
			if (canFire _x) then {
				if _rearm then {
					_x setVehicleAmmo 1;
				};
				gunner _x doWatch (_allPos call BIS_fnc_selectRandom);
				sleep random _sleepTime;
				_x action ["useWeapon", _x, gunner _x,1];
			} else {
				_arrayOfVehicles = _arrayOfVehicles - [_x];
			};
		} forEach _arrayOfVehicles;

	} forEach _arrayOfUnits;

};

true;

params ["_turretsArray", "_target", "_sleepTime","_barrageTimeLength","_startTime","_turret","_shellType","_soundName"];
_turretsArray = _this select 0;
_target = _this select 1;
_sleepTime = (_this select 2);
_barrageTimeLength = (_this select 3);
_shellType = (_this select 4);
_soundName = (_this select 5);
_startTime = time;
sleep _sleepTime;
while {time < (_startTime + _barrageTimeLength)} do {
	for "_i" from 0 to (count _turretsArray - 1) do {
		 _turret = (_turretsArray select _i);
		if ( random 1 > 0.55) then {
			[_turret,_target,2000,_shellType,50,time,300] spawn TG_fnc_fireLaser;
			playSound _soundName;
			//playSound3D ["lasershot01",_turret ,false, getPosATL _turret, 1, 1, 0];
		};
	};
	sleep .5;
};
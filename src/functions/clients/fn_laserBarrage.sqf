params ["_turretsArray", "_target", "_sleepTime","_barrageTimeLength","_startTime","_turret"];
_turretsArray = _this select 0;
_target = _this select 1;
_sleepTime = (_this select 2);
_barrageTimeLength = (_this select 3);
_startTime = time;
sleep _sleepTime;
while {time < (_startTime + _barrageTimeLength)} do {
	for "_i" from 0 to (count _turretsArray - 1) do {
		 _turret = (_turretsArray select _i);
		if ( random 1 > 0.75) then {
			[_turret,_target,2000,"3AS_Mass_Driver_Shell",15,60,time] spawn TG_fnc_fireLaser;
			playSound "3as_Arc_Light_Energy_shell";
		};
	};
	sleep .5;
};
params ["_source","_target","_speed", 
"_laser","_projectileType","_initialPos",
"_vectorFromTo","_scale","_distanceToTarget","_fps","_startTime","_process","_totalTime","_laserUX","_focus_spread"];	

private _source = (getPosASL (_this select 0));
private _target = (getPosASL (_this select 1));
private _speed = _this select 2;
private _projectileType = _this select 3;
private _scale = _this select 4;
private _startTime = _this select 5;
private _focus_spread = _this select 6;
private _target = _target vectorAdd [random [-_focus_spread,0,_focus_spread], random [-_focus_spread,0,_focus_spread], 0];
private _vectorFromTo = _source vectorFromTo _target;
_initialPos = (_source) vectorAdd (_vectorFromTo vectorMultiply 3);
private _laser = _projectileType createVehicle (_source);
_laser hideObject true;
private _laserUX = _projectileType createVehicle (getPosASL _laser);
_laserUX setObjectScale _scale;
_laserUX attachTo [_laser, [0,0,0]];
_laser setVectorDirAndUp [_vectorFromTo, [0,0,1]];
_laserUX setObjectScale _scale;
private _distanceToTarget = _source distance _target;
private _totalTime = (_distanceToTarget / _speed);
while {time < (_startTime + _totalTime)} do {
	_laser setVelocityTransformation [
		_initialPos,
		_target,
		[0,1,0],
		[0,1,0],
		vectorDir _laser,
		vectorDir _laser,
		vectorUp _laser,
		vectorUp _laser,
		(time - _startTime) / _totalTime
	];
	sleep (1 / diag_fps);
};
deleteVehicle _laserUX;
//_laser setVelocityModelSpace [0, 1000,0];
deleteVehicle _laser;
bomb = "ATMine_Range_Ammo" createVehicle (getPosASL _laser);
bomb setdamage 1;
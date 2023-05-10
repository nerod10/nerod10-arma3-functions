
params ["_playerShip", "_speed", "_maxSpeed",
 "_speedAcceleration", "_maxPitchAngle", "_maxPithcTurnSpeed",
  "_maxTurnSpeed", "_maxRoll", "_invertY",
   "_fireWeapon", "_pitchTruenSpeedFactor", "_yaw",
    "_pitch", "_roll", "_XPosition",
	 "_YPosition","_TAG_LShift","_TAG_Z",
	 "_turnSpeedacceleration","_fire","_disp","_ctrl"];
private _playerShip = _this select 0;
private _TAG_LShift = false;
private _TAG_Z = false;
private _maxPitchAngle = 180; //for capital ships, this should be ~30
private _speed=1;
private _speedAcceleration = 0.1; //for capital ships, this should be ~0.02
private _maxSpeed = 2;
private _turnSpeedacceleration = 0.05;
private _maxTurnSpeed = 180;
private _maxPithcTurnSpeed = 5;
private _yaw = getDir XWing;
private _pitchTruenSpeedFactor = 1;
private _pitch = 0;
private _roll = 0;
private _maxRoll = 40; //for capital ships, this should be 20
private _XPosition = 0;
private _YPosition = 0;
private _invertY = true;
private _fire = false;
private _fireWeapon = str (weaponsItems XWing select 0 select 0);

private _disp = findDisplay 46 createDisplay "RscDisplayEmpty";
private _ctrl = _disp ctrlCreate ["RscBackground", -1];
_ctrl ctrlSetBackgroundColor [0, 0, 0, 0];
_ctrl ctrlSetPosition [0, 0, 1, 1];
_ctrl ctrlCommit 0;
ctrlSetFocus _ctrl;

_disp displayAddEventHandler ["MouseMoving", {
	if (alive player) then {
		getMousePosition params ["_xpos","_ypos"]; //get mouse position
		if (invertY) then {
			private _ypos = _ypos * -1; //invert y
			private _ypos = _ypos + 1.2; //move y
		};
		_XPosition = _xpos-0.5;
		_XPosition = _ypos;
		// if the ship is upside down, invert the roll and pitch
		if (_pitch > 90) then {
			_roll = -_XPosition * _maxRoll;
			_pitch = 180 - _pitch;
		};
		if (_pitch < -90) then {
			_roll = _XPosition * _maxRoll;
			_pitch = -180 - _pitch;
		};

	}
}];

_disp displayAddEventHandler ["KeyDown", 
{
	private _keyPress = _this select 1;
	if (_keyPress == 16) then {_TAG_LShift=true;};
	if (_keyPress == 44) then {_TAG_Z=true;};
}];
_disp displayAddEventHandler ["KeyUp", 
{
	_keyPress = _this select 1;
	if (_keyPress == 16) then {_TAG_LShift=false;};
	if (_keyPress == 44) then {_TAG_Z=false;};
}];
//fire
_disp displayAddEventHandler ["MouseButtonDown", 
{
	_keyPress = _this select 1;
	
	if (_keyPress == 0) then {
		[_playerShip, toString [_fireWeapon]] call BIS_fnc_fire;
	};
}];

while {alive player} do {
	//movment:
	//speed
	if (_TAG_LShift) then {_speed = _speed + _speedAcceleration;}; 
	if (_TAG_Z) then {_speed = _speed - _speedAcceleration;}; 
	if (_speed > _maxSpeed) then {_speed = _maxSpeed;};
	if (_speed < 0) then {_speed = 0;};

	//pitch
	_pitchTruenSpeed = _maxPithcTurnSpeed * (YPosition - 0.5);
	if (_pitchTruenSpeed > _maxPithcTurnSpeed) then {_pitchTruenSpeed = _maxPithcTurnSpeed;};
	if (_pitchTruenSpeed < -_maxPithcTurnSpeed) then {_pitchTruenSpeed = -_maxPithcTurnSpeed;};
	_pitch = _pitch + _pitchTruenSpeed * _pitchTruenSpeedFactor;
	if (_pitch > _maxPitchAngle) then {_pitch = _maxPitchAngle;};
	if (_pitch < -_maxPitchAngle) then {_pitch = -_maxPitchAngle;};

	//yaw
	_yaw = _yaw + _turnSpeedacceleration * _roll;
	if (_yaw > 360) then {_yaw = 0;};
	if (_yaw < 0) then {_yaw = 360;};
	

	//roll
	//if the ship is upside down, invert the roll
	if (_pitch > 90) then {_roll = -XPosition * _maxRoll;};
	if (_pitch < -90) then {_roll = XPosition * _maxRoll;};
	if (_pitch < 90 && _pitch > -90) then {_roll = XPosition * _maxRoll;};
	if (_roll > _maxRoll) then {_roll = _maxRoll;};
	if (_roll < -_maxRoll) then {_roll = -_maxRoll;};
	
	//set position
	_playerShip setVectorDirAndUp [
		[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch], 
		[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D 
	]; 
	_playerShip setPosASL (getPosASL _playerShip vectorAdd [sin _yaw * cos _pitch * _speed, cos _yaw * cos _pitch * _speed, sin _pitch * _speed]);


	sleep 0.03333; //30fps
}

//anim1 = [t5,b11,2,120,1] spawn TG_fnc_movingBox; sleep 0.5;
params ["_mainMovingObj", "_destinationObj", "_animationLength", 
		"_animationFPS","_delayAnimation","_keepFinalPosition", 
		"_nextVectorDir", "_nextVectorUp",
		"_fromPosASL", "_toPosASL", "_controlPointASL",
		"_toControlPointOffset", "_toVectorDirOffset", "_toVectorUpOffset",
		 "_fromDir","_toDir","_fromUp","_toUp","_startTime","_endTime","_interval"];
 _mainMovingObj = _this select 0;
 _destinationObj = _this select 1;
 _animationLength = _this select 2;
 _animationFPS = _this select 3;

 _fromPosASL = getPosASL _mainMovingObj;
 _toPosASL = getPosASL _destinationObj;
 _fromDir = vectorDir _mainMovingObj;
 _toDir = vectorDir _destinationObj;
 _fromUp = vectorUp _mainMovingObj;
 _toUp = vectorUp _destinationObj;

//_mainMovingObj attachTo [_destinationObj];
sleep (_delayAnimation);
 _startTime = time;
 _endTime = _startTime + _animationLength;
 _interval = linearConversion [_startTime, _endTime, time, 0, 1];
//detach _mainMovingObj;
while {(_interval < 1)} do
{
	_interval = linearConversion [_startTime, _endTime, time, 0, 1];
	_mainMovingObj setVelocityTransformation
	[
		_fromPosASL,
		_toPosASL,
		[0,0,0],
		[0,0,0],
		_fromDir,
		_toDir,
		_fromUp,
		_toUp,
		_interval
	];
	sleep (1/_animationFPS);
};
_mainMovingObj attachTo [_destinationObj];



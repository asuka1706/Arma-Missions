// _igiload = execVM "IgiLoad\IgiLoadInit.sqf";
{
    if (side _x isEqualTo WEST) then {
	_x addEventHandler ["HandleDamage", {[_this select 0, _this select 3] call fnc_injuresource}];
    };
    if (side _x isEqualTo OPFOR) then {
	_x setSkill ["aimingAccuracy", 0.20];
	_x setSkill ["aimingSpeed", 0.40];
        _x setSkill ["aimingShake", 0.30];
        _x setSkill ["courage", 0.20];
        _x setSkill ["spotTime", 0.60];
    };
} forEach allUnits;

fnc_injuresource = {
    _target = _this select 0;
    _killer = _this select 1;

    if (isPlayer _killer) then { 
	_killer setCaptive false;
    };
};
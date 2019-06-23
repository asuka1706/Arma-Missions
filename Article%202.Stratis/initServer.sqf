CivKillCounter = 0;

addMissionEventHandler ["EntityKilled",{

    params ["_killedUnit","_killer","_triggerMan"];

    if (side _killedUnit isEqualTo civilian) then {

        CivKillCounter = CivKillCounter + 1;

        if (CivKillCounter >= 5) then {executionSuccess = true};

    };

}];


addMissionEventHandler ["BuildingChanged",{_obj = [_this select 0,_this select 1,_this select 2] call fnc_buildingruined;
    if ((_obj select 0 == "Land_Radar_ruins_F")&&(_obj select 1 == "scripted_removed")) then {radarDestroyed = true};
}];

fnc_buildingruined = {
if (isnil "MapDamage") then {
	MapDamage = [];			
}; //Create our MD variable if we haven't already.

private _object = _this select 0;
private _newobject = _this select 1;
private _ruin = _this select 2;
private _netID = netid _object;

if (_ruin) then {
//It's completely destroyed, based on the return from the mission event handler.

	//If its not a native map object, see if it's a product of a previously recorded destruction.
	if ((netid _object find "-") == -1) then { //Not a native.  
		if !((MapDamage select {_x select 1 == netid _object}) isEqualTo []) then {
			_oldobject = ((MapDamage select {_x select 1 == netid _object}) select 0) select 0;//This should return the netID of its original object
			//This code here will run if the item passed was not native, but was a product of a native object decaying into ruin.
			[_oldobject, "native_decayed" ];
		} else {
			//This code here will run if it was not a map object and not a product of a map object decaying into ruin.
			//AKA a script placed item dieing completely.
			//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
			[typeOf _newobject, "scripted_removed"];
		};
	} else { 
		[typeOf _newobject, "native_ruin"];
	};
} else {
//It's only partially damaged.
	//If its not a native map object, see if it's a product of a previously recorded destruction.
	if ((netid _object find "-") == -1) then { 
		if !((MapDamage select {_x select 1 == netid _object}) isEqualTo []) then {
			_oldobject = str (MapDamage select {_x select 1 == netid _object}) select 0;
			
			//Its a native map object passing through another phase of its destruction, but is not ruined yet.
			[_oldobject, "native_damaged"];
		} else {
		
			//It was never a native map object and it's not completely ruined.
			//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
			[typeOf _newobject, "scripted_damaged"];
		};
	} else {
		//A native map object produced a non-native object.
		MapDamage pushBack [netid _object,netid _newobject];
        [typeOf _newobject, "native_transformed"];
	};
};
}
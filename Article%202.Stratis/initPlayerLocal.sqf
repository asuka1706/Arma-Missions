[] execVM "briefing.sqf";

player addEventHandler['Fired', {
    if ((player inArea girna_trigger) && (_this select 4 find "Remote_Ammo" > -1)) then
        {_expl = "B_HMG_01_F" createVehicle getPos player;
		_expl setVehicleLock "LOCKED";
		hideobject _expl;
		_expl addEventHandler['Explosion', {shotIsFiredGirna = true;}];};
    if ((player inArea agia_trigger) && (_this select 4 find "Remote_Ammo" > -1)) then
        {_expl = "B_HMG_01_F" createVehicle getPos player;
		_expl setVehicleLock "LOCKED";
		hideobject _expl;
		_expl addEventHandler['Explosion', {shotIsFiredAgia = true;}];};
    if ((player inArea girna_trigger) && (_this select 4 find "Remote_Ammo" == -1)) then {shotIsFiredGirna = true;} else {
    if ((player inArea agia_trigger) && (_this select 4 find "Remote_Ammo" == -1)) then {shotIsFiredAgia = true;};}
}];
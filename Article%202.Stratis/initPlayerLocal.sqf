[] execVM "briefing.sqf";

player addEventHandler['Fired', {if ((player inArea girna_trigger) && (_this select 4 find "Remote_Ammo" == -1)) then {shotIsFired = true;};
if ((player inArea girna_trigger) && (_this select 4 find "Remote_Ammo" > -1)) then {(_this select 6) addEventHandler['Deleted', {hint 'EXPLOSION'}];};
}];
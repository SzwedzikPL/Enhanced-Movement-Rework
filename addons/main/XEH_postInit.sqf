#include "script_component.hpp"

["Enhanced Movement Rework","EMR_action","All-in-one action",{
	if (GVAR(climbingEnabled) || GVAR(jumpingEnabled)) then {
		(call CBA_fnc_currentUnit) call FUNC(action)
	} else {false}
},{false},[47,[true,false,false]]] call CBA_fnc_addKeybind;

["Enhanced Movement Rework","EMR_climb","Climb/drop only",{
	if (GVAR(climbingEnabled)) then {
		(call CBA_fnc_currentUnit) call FUNC(climb)
	} else {false}
},{false},[0,[false,false,false]]] call CBA_fnc_addKeybind;

["Enhanced Movement Rework","EMR_jump","Jump only",{
	if (GVAR(jumpingEnabled)) then {
		(call CBA_fnc_currentUnit) call FUNC(jump)
	} else {false}
},{false},[0,[false,false,false]]] call CBA_fnc_addKeybind;

["Enhanced Movement Rework","EMR_holster","Holster weapon",{// From ACE3
	private _player = call CBA_fnc_currentUnit;

	if !(_player call CBA_fnc_canUseWeapon) exitWith {false};

	if ((currentWeapon _player) != "") then {
		_player action ["SwitchWeapon",_player,_player,299];
	} else {
		private _weapon = switch (true) do {
			case (primaryWeapon _player != ""): {primaryWeapon _player};
			case (handgunWeapon _player != ""): {handgunWeapon _player};
			case (secondaryWeapon _player != ""): {secondaryWeapon _player};
			default {""};
		};

		if (_weapon != "") then {_player selectWeapon _weapon};
	};

	true
},{false},[0,[false,false,false]],false] call CBA_fnc_addKeybind;

if (hasInterface) then {
	GVAR(walkableSurface) = "babe_helper" createVehicleLocal [0,0,0];
	GVAR(walkableSurfacePFHID) = [FUNC(updateWalkableSurface),0] call CBA_fnc_addPerFrameHandler;
};

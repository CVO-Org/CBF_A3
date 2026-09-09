#include "..\script_component.hpp"
/*
 * Authors: PabstMirror
 * Lists Config Classes to RPT which are missing XEH support.
 * Source: https://github.com/athena413/POTATO/blob/ec10a478da5d2c010dc54a73366d6541f0f656a4/addons/miscFixes/dev_xehFix.sqf
 *
 * Arguments:
 * None.
 *
 * Return Value:
 * <NONE>
 *
 * Example:
 * paste in Debug consolse and run
 *
 * Public: No
 */

diag_log text format ["--- Dumping XEH ---"];

private _reqAddons = [];
private _defined = [];

private _problems = [true] call CBA_fnc_supportMonitor;
{
    _x params ["_vehType", "_addon"];
    private _parent = configName inheritsFrom (configFile >> "CfgVehicles" >> _vehType);
    if (!(_parent in _defined)) then {
        diag_log text format ["class %1;", _parent];
        _defined pushBack _parent;
    };
    private _displayName = getText (configFile >> "CfgVehicles" >> _vehType >> "displayName");
    private _sourceAddons = configSourceAddonList (configFile >> "CfgVehicles" >> _vehType);
    _reqAddons append _sourceAddons;
    diag_log text format ["class %1: %2 { XEH_ENABLED; }; // ""%3"" %4", _vehType, _parent, _displayName, _addon];
} forEach _problems;

diag_log text format ["_reqAddons %1", _reqAddons arrayIntersect _reqAddons];

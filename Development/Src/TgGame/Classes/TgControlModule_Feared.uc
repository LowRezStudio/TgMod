class TgControlModule_Feared extends TgControlModule_ThirdPerson
    config(Engine);

var float c_fLastSwitchTime;
var float c_fNextSwitchTime;
var Vector c_vCurrentDirection;

function OnBecomeActive(TgControlModule OldModule) { }

function Vector CalcNewAccel() { }

function ChangeDirections() { }

function UpdateRotation(float DeltaTime) { }

defaultproperties
{
    c_fNextSwitchTime=-1.0000000
}

class TgDeviceVolume_Pulse extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var Controller DamageInstigator;
var (Object) editconst int m_nMapObjectId;
var () int s_nDeviceId;
var TgDeviceFire m_FireMode;
var int s_nTeamNumber;
var () byte s_nTaskForce;

native function bool SetupDevice();  // Export UTgDeviceVolume_Pulse::execSetupDevice(FFrame&, void* const)

simulated event PostBeginPlay() { }

function OnSetDamageInstigator(SeqAct_SetDamageInstigator Action) { }

simulated function OnToggle(SeqAct_Toggle inAction) { }

function TurnOn() { }

function TurnOff() { }

function Fire() { }

native function FindTouchingActorsFromScript();  // Export UTgDeviceVolume_Pulse::execFindTouchingActorsFromScript(FFrame&, void* const)

simulated function ImpactInfo CalcDeviceFire(Vector StartTrace, Vector EndTrace, optional out array<ImpactInfo> ImpactList) { }

defaultproperties
{}

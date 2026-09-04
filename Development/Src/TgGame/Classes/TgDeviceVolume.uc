class TgDeviceVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () bool bPainCausing;
var bool BACKUP_bPainCausing;
var bool s_bDeviceActive;
var Info PainTimer;
var Controller DamageInstigator;
var (Object) editconst int m_nMapObjectId;
var () int s_nDeviceId;
var TgDeviceFire s_DeviceFireMode;
var () byte s_nTaskForce;

native function bool SetupDevice();  // Export UTgDeviceVolume::execSetupDevice(FFrame&, void* const)

simulated event PostBeginPlay() { }

function Reset() { }

simulated function OnToggle(SeqAct_Toggle inAction) { }

function TimerPop(TgDeviceVolumeInfo T) { }

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

function CausePainTo(Actor Other) { }

function bool CanCausePainTo(Actor Other) { }

function OnSetDamageInstigator(SeqAct_SetDamageInstigator Action) { }

function ApplyHit(Actor Target) { }

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action) { }

event int GetSupportedTaskforce() { }

defaultproperties
{}

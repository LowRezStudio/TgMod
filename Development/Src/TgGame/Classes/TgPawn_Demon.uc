class TgPawn_Demon extends TgPawn_Character
    native(ChampDemon)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var () WeaponDOF m_CurrentDOFSettings;
var bool r_bIsUltActive;
var bool r_bIsUltTargeting;
var bool m_bUseTelepunchZoom;
var bool m_bTelepunchTargetLocked;
var TgPawn_Character m_TelepunchTarget;

replication {
    if(bNetDirty) r_bIsUltActive, r_bIsUltTargeting;
}

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

native function DeviceOnStartFire(TgDevice Dev);  // Export UTgPawn_Demon::execDeviceOnStartFire(FFrame&, void* const)

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration) { }

reliable server event ServerNotifyTelepunchTarget(TgPawn_Character pTarget) { }

function OnUltStarted() { }

reliable client simulated function ClientOnUltStarted() { }

function OnUltFinished() { }

reliable client simulated function ClientOnUltFinished() { }

simulated function PauseDeviceTimers(bool bPaused) { }

defaultproperties
{}

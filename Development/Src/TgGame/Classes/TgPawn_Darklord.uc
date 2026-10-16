class TgPawn_Darklord extends TgPawn_Character
    native(ChampDarklord)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

var bool m_bUseWhirlZoom;

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn_Darklord::execDeviceAdjustDamage(FFrame&, void* const)

simulated function AddJoinForcedView(TgPawn_Character Source, TgPawn_Character Target) { }

simulated function RemoveJoinForcedView(TgPawn_Character Source, TgPawn_Character Target) { }

function TgPawn.EEmote GetDeviceEmoteType(TgDevice Dev) { }

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining) { }

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}

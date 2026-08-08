class TgPawn_Viktor extends TgPawn_Character
    native(ChampViktor)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var float r_fFragGrenadeExplodeTime;
var bool r_bFragGrenadeExplodeOnTouch;
var (Grenade) float m_fBounceDampingVertMin;
var (Grenade) float m_fBounceDampingVertMax;
var (Grenade) float m_fBounceDampingHorizMin;
var (Grenade) float m_fBounceDampingHorizMax;
var repnotify byte r_nGrenadeRefreshSound;
var repnotify byte r_nAmmoRefreshSound;
var () WeaponDOF m_CurrentDOFSettings;
var TgDevice_Hustle m_CachedHustleDevice;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_bFragGrenadeExplodeOnTouch, r_fFragGrenadeExplodeTime;
}

simulated event bool StartAction(TgDevice Dev, optional out TgObject.EDeviceFailType failType, optional bool bUpdateTimeStamp=true) { }

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy) { }

simulated event ReplicatedEvent(name VarName) { }

simulated event PlayLocalPawnFX(name nmDisplayGroup) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

native simulated function TgObject.TG_EQUIP_POINT GetPerCharacterAltEquipPoint();  // Export UTgPawn_Viktor::execGetPerCharacterAltEquipPoint(FFrame&, void* const)

defaultproperties
{}

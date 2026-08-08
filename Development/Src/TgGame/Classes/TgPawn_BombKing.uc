class TgPawn_BombKing extends TgPawn_Character
    native(ChampBombKing)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

enum EWeaponMeshState {
    WMS_Inhand,  // 0
    WMS_Grumpy,  // 1
    WMS_Poppy,  // 2
};

var (BouncyBomb) float m_fBounceDampingVertMin;
var (BouncyBomb) float m_fBounceDampingVertMax;
var (BouncyBomb) float m_fBounceDampingHorizMin;
var (BouncyBomb) float m_fBounceDampingHorizMax;
var bool c_bRenderKingBombMesh;
var bool m_bForced3PDuringKingBomb;
var int c_nKingBombMeshID;
var () Vector m_fKingBombCameraOffset;
var repnotify TgPawn_BombKing.EWeaponMeshState r_weaponMeshState;
var int m_nInhandID;
var int m_nGrumpyBombID;
var int m_nPoppyBombID;
var float r_fJoltKnockback;
var Class<TgDevice> m_InhandClass;
var Class<TgDevice> m_GrumpyBombClass;
var Class<TgDevice> m_PoppyBombClass;

replication {
    if((bNetDirty && !bNetInitial) && !bNetOwner || bDemoRecording) r_weaponMeshState;
    if(bNetDirty && int(Role) == int(ENetRole.ROLE_Authority)) r_fJoltKnockback;
}

native function ReloadMeshAssemblies();  // Export UTgPawn_BombKing::execReloadMeshAssemblies(FFrame&, void* const)

native function bool ShouldBeFirstPersonThisTick();  // Export UTgPawn_BombKing::execShouldBeFirstPersonThisTick(FFrame&, void* const)

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn_BombKing::execDeviceAdjustDamage(FFrame&, void* const)

native function OnPawnDied();  // Export UTgPawn_BombKing::execOnPawnDied(FFrame&, void* const)

simulated function OnRespawn() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function SwapToKingBombMesh() { }

simulated function SwapFromKingBombMesh() { }

reliable server function SwitchToStickyBomb() { }

reliable server function SwitchToGrumpyBomb() { }

reliable server function SwitchToPoppyBomb() { }

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function Vector GetCameraOffsetOverride(Vector originalOffset) { }

simulated function PlayDyingEffects() { }

simulated event PreTimeLapse(bool bPlayOfTheGame) { }

simulated event PostTimeLapse(bool bPlayOfTheGame) { }

simulated function SpecialHideStickyBomb(int projID, int deployID) { }

defaultproperties
{}

class TgPawn_Tower_FA extends TgPawn_Tower
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

enum ETowerType {
    TowerType_Default,  // 0
    TowerType_Inner,  // 1
    TowerType_Outer,  // 2
    TowerType_Upper,  // 3
};

var TgPawn_Tower_FA.ETowerType m_TowerType;
var repnotify Rotator r_InitialOrientation;
var export editinline ParticleSystemComponent c_AimVisibilityMesh;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_InitialOrientation;
}

native function bool CanSeeActor(Actor Other);  // Export UTgPawn_Tower_FA::execCanSeeActor(FFrame&, void* const)

simulated function SetAimVisibilityMesh() { }

simulated function PlayDyingEffects() { }

simulated function PostBeginPlay() { }

simulated event ReplicatedEvent(name VarName) { }

simulated event Vector GetWeaponStartTraceLocation(optional Weapon CurrentWeapon) { }

simulated function OnDeviceFormFire(int nEquipSlot, float fRefireTime, int nFireMode) { }

defaultproperties
{}

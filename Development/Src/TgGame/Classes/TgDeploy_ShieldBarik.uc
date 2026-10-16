class TgDeploy_ShieldBarik extends TgDeploy_Shield
    native(ChampBarik)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var repnotify bool r_bHasCapsule;
var repnotify bool r_bHasAcceleratorField;
var repnotify bool r_bHasImpede;
var repnotify bool r_bHasBunker;
var repnotify bool r_bHasFortify;
var array<Actor> m_AcceleratedActors;
var TgPawn m_CachedPawnOwner;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_bHasCapsule;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHasAcceleratorField, r_bHasBunker, r_bHasFortify, r_bHasImpede;
}

native function ToggleFX();  // Export UTgDeploy_ShieldBarik::execToggleFX(FFrame&, void* const)

native function ToggleLockdownMode(bool bSetActive);  // Export UTgDeploy_ShieldBarik::execToggleLockdownMode(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}

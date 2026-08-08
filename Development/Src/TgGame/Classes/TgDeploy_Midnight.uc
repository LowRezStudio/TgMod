class TgDeploy_Midnight extends TgDeployable
    native(ChampBlades)
    placeable
    hidecategories(Navigation)
    config(Engine);

var repnotify float r_fPersistTime;
var TgPawn r_TargetPawn;
var MaterialInstanceConstant m_pMIC;
var const Class<TgMidnightFogVolumeDensityInfo> m_FogInfoClass;
var TgMidnightFogVolumeDensityInfo m_FogInfo;
var bool m_bCleanedUp;
var bool m_b3PFxActive;
var bool m_b1PSoundActive;

replication {
    if(bNetDirty && int(Role) == int(ENetRole.ROLE_Authority)) r_TargetPawn, r_fPersistTime;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event SetPersistTimer() { }

native function ApplyCameraEffectParams();  // Export UTgDeploy_Midnight::execApplyCameraEffectParams(FFrame&, void* const)

simulated function MidnightDeployablePersistTimer() { }

simulated function Destroyed() { }

simulated event DestroyIt(optional bool bSkipFx) { }

simulated function Cleanup() { }

native function MaterialInstanceConstant CreateMIC(MaterialInterface pMaterialInterface);  // Export UTgDeploy_Midnight::execCreateMIC(FFrame&, void* const)

simulated event SpawnFog() { }

simulated event SetFogEnabled(bool bEnabled) { }

simulated event SetFogDistance(float fDistance) { }

simulated event SetFogAlpha(float fAlpha) { }

simulated event SetFogOrigin(Vector vOrigin) { }

defaultproperties
{}

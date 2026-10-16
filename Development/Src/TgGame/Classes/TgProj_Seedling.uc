class TgProj_Seedling extends TgProj_FreeGrenade
    native(ChampFairy)
    hidecategories(Navigation)
    config(Engine);

var const int m_nSecondaryProjToSpawn;
var int m_nSpawnsRemaining;
var export editinline SkeletalMeshComponent m_CachedSMC;
var TgSkelControlSingleBone m_GrenadeSkelControl;
var TgSkelControlSingleBone m_SpikesSkelControl;
var MaterialInstanceConstant m_fCachedMIC;
var Rotator m_rRotationalVelocity;
var export editinline TgSilhouetteComponent m_Silhouette;
var LinearColor m_LocalSilhouetteColor;
var bool m_bSilhouetteInitialized;
var bool m_bSilhouetteAllowed;
var bool m_bBuildupSoundPlayed;

native function Vector GetRotatedAim(Vector initialAim, int Angle);  // Export UTgProj_Seedling::execGetRotatedAim(FFrame&, void* const)

native function InitializeSilhouetteComponent();  // Export UTgProj_Seedling::execInitializeSilhouetteComponent(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated event bool CheckTeamPassThrough(Actor Other) { }

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem) { }

function float GetPostLandDuration() { }

function StartLandExplodeTimer() { }

defaultproperties
{}

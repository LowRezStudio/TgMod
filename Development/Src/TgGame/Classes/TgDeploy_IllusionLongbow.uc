class TgDeploy_IllusionLongbow extends TgDeployable
    native(ChampLongbow)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var int c_nDefaultBodyMeshId;
var int c_nDefaultHeadMeshId;
var int c_nDefaultWeaponMeshId;
var export editinline TgSkeletalMeshComponent m_HeadMesh;
var export editinline TgSkeletalMeshComponent_Weapon m_WeaponMesh;
var array<MaterialInstanceConstant> m_bodyReplacementMICs;
var array<MaterialInstanceConstant> m_headReplacementMICs;
var array<MaterialInstanceConstant> m_weaponReplacementMICs;
var bool m_bFadingAway;
var const float m_fLifeAfterDeathOverride;
var TgCollisionProxy_Cylinder m_FxCollisionProxy;
var float m_fCollisionRadius;

native function UpdateFadeAway();  // Export UTgDeploy_IllusionLongbow::execUpdateFadeAway(FFrame&, void* const)

native function FixupMeshComponent(int nMeshId, TgSkeletalMeshComponent Component);  // Export UTgDeploy_IllusionLongbow::execFixupMeshComponent(FFrame&, void* const)

native function ReplaceWithFadeOutMaterial();  // Export UTgDeploy_IllusionLongbow::execReplaceWithFadeOutMaterial(FFrame&, void* const)

simulated event OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event OnProxyUnTouch(Actor Other) { }

simulated event DestroyIt(optional bool bSkipFx) { }

simulated event Destroyed() { }

simulated event SpawnCollisionProxy() { }

defaultproperties
{}

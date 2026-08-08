class TgProj_FreeGrenade extends TgProj_Simulated
    native(Projectiles)
    hidecategories(Navigation)
    config(Engine);

var bool m_bShieldTouched;
var bool m_bExplodeOnTouch;
var bool m_bExplodeOnGeometry;
var bool m_bExplodeOnFloor;
var bool m_bUseBilinearInterpolationForBounceDamping;
var bool m_bUseGravityZOverride;
var TgDeployable m_TouchedShield;
var float m_fToleranceZ;
var float m_fBounceDampingVertMin;
var float m_fBounceDampingVertMax;
var float m_fBounceDampingHorizMin;
var float m_fBounceDampingHorizMax;
var float m_fBounceDamping;
var float m_fSpeedToActivateBounceFX;
var float m_fGravityZOverride;
var int m_nBounceCount;
var int m_nBouncesToExplode;
var float m_fBounceDistinctionDuration;
var int m_fLastBounceTime;
var Vector m_vRecentHitNormal;
var float m_fRecentHitTime;

native function float GetGravityZ();  // Export UTgProj_FreeGrenade::execGetGravityZ(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function ShutDown() { }

simulated function Timer() { }

simulated event PlayHitWallExplosionFX(Vector HitNormal, Vector HitLocation) { }

simulated function PlayHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded) { }

function float GetPostLandDuration() { }

function StartLandExplodeTimer() { }

function OnLand() { }

simulated event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp) { }

simulated function bool ShouldHitBounce(Actor Target, Vector HitNormal) { }

simulated function ApplyBounce(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp) { }

simulated function PlayBounceSound() { }

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal) { }

simulated event Landed(vector HitNormal, actor FloorActor) { }

simulated function Destroyed() { }

defaultproperties
{}

class TgDeploy_BombKingStickyBomb extends TgDeployable
    native(ChampBombKing)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var bool r_bDetonated;
var bool c_bSuppressExplosion;
var repnotify bool r_bShouldDetach;
var repnotify TgPawn_Character r_StuckPlayer;
var name m_StuckSocket;
var TgPawn_Character m_CachedPlayer;
var repnotify Vector r_HitNormal;
var float m_fCachedCollisionRadius;
var float m_fCachedCollisionHeight;
var TgSpecialFx m_GetStuckFx;
var TgSpecialFx m_StickOtherFx;
var TgPawn_LanePusherBase r_StuckCart;
var Rotator r_StuckRotation;
var Vector r_CartOffset;
var TgDeployable r_StuckGeometry;
var repnotify int r_nOriginalProjectileID;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_CartOffset, r_HitNormal, r_StuckCart, r_StuckGeometry, r_StuckPlayer, r_StuckRotation, r_bDetonated, r_bShouldDetach;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_nOriginalProjectileID;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event HideSpawningProjectile() { }

simulated event DestroyIt(optional bool bSkipFx) { }

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

function DetachTimer() { }

simulated event DetachFromPlayer() { }

simulated event Check1PHide() { }

simulated event StickToPlayerSocket() { }

simulated function Tick(float DeltaSeconds) { }

event Landed(vector HitNormal, actor FloorActor) { }

event ExplodeOnShield() { }

function InstantFireDeployable() { }

simulated function CheckHideHUDOverlay() { }

defaultproperties
{}

class TgDeploy_PoppyBomb extends TgDeployable
    native(ChampBombKing)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var bool r_bDetonated;
var TgPawn_Character m_CachedPlayer;
var repnotify Vector r_HitNormal;
var float m_fCachedCollisionRadius;
var float m_fCachedCollisionHeight;
var TgPawn_LanePusherBase r_StuckCart;
var Rotator r_StuckRotation;
var Vector r_CartOffset;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_CartOffset, r_HitNormal, r_StuckCart, r_StuckRotation, r_bDetonated;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event DestroyIt(optional bool bSkipFx) { }

event Landed(vector HitNormal, actor FloorActor) { }

event ExplodeOnShield() { }

defaultproperties
{}

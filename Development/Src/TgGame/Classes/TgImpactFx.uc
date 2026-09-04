class TgImpactFx extends Object
    native(FX)
    config(Engine);

const TGIFGT_FOOTSTEP_RUN = 760;

const TGIFGT_FOOTSTEP_WALK = 815;

const TGIFGT_FOOTSTEP_SCUFF = 816;

const TGIFGT_GRENADE_BOUNCE = 761;

const TGIFGT_WEAPON_IMPACT = 762;

struct IMPACT_FX {
    var name nmMaterialType;
    var SoundCue Sound;
    var MaterialInterface DecalMaterial;
    var float fDecalWidth;
    var float fDecalHeight;
    var bool bRandomRotation;
    var ParticleSystem Particles;
    var TgSpecialFx SpecialFx;
    structdefaultproperties {}
};

var float c_fMaxFxDistance;
var bool c_bAlignToSurfaceNormal;
var IMPACT_FX c_EmptyImpact;
var array<IMPACT_FX> c_Impacts;

function bool IsEffectRelevant(Actor Viewer, Vector HitLocation) { }

function IMPACT_FX GetImpactFx(optional PhysicalMaterial HitMaterial) { }

function ApplyImpact(Actor Instigator, Actor HitActor, Vector HitLocation, Vector HitNormal, optional IMPACT_FX Impact) { }

defaultproperties
{
    c_EmptyImpact=(nmMaterialType="None",Sound=none,DecalMaterial=none,fDecalWidth=0.0000000,fDecalHeight=0.0000000,bRandomRotation=true,Particles=none,SpecialFx=none)
}

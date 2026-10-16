class TgImpactFx extends Object
    native(FX);

const TGIFGT_FOOTSTEP_RUN = 760;
const TGIFGT_FOOTSTEP_WALK = 815;
const TGIFGT_FOOTSTEP_SCUFF = 816;
const TGIFGT_GRENADE_BOUNCE = 761;
const TGIFGT_WEAPON_IMPACT = 762;

struct native IMPACT_FX
{
    var name nmMaterialType;
    var SoundCue Sound;
    var MaterialInterface DecalMaterial;
    var float fDecalWidth;
    var float fDecalHeight;
    var bool bRandomRotation;
    var ParticleSystem Particles;
    var TgSpecialFx SpecialFx;

    structdefaultproperties
    {
        nmMaterialType="None"
        Sound=none
        DecalMaterial=none
        fDecalWidth=0.0000000
        fDecalHeight=0.0000000
        bRandomRotation=true
        Particles=none
        SpecialFx=none
    }
};

var float c_fMaxFxDistance;
var bool c_bAlignToSurfaceNormal;
var IMPACT_FX c_EmptyImpact;
var array<IMPACT_FX> c_Impacts;

function bool IsEffectRelevant(Actor Viewer, Vector HitLocation)
{
    return Viewer.EffectIsRelevant(HitLocation, false, c_fMaxFxDistance);
    //return ReturnValue;    
}

function IMPACT_FX GetImpactFx(optional PhysicalMaterial HitMaterial)
{
    local int I;
    local TgPhysicalMaterialProperty PhysicalProperty;

    // End:0x4B
    if(HitMaterial != none)
    {
        PhysicalProperty = TgPhysicalMaterialProperty(HitMaterial.GetPhysicalMaterialProperty(Class'TgGame.TgPhysicalMaterialProperty'));
    }
    // End:0x94
    if((PhysicalProperty == none) || PhysicalProperty.MaterialType == 'None')
    {
        return c_Impacts[0];
    }
    I = 0;
    J0x9F:

    // End:0x122 [Loop If]
    if(I < c_Impacts.Length)
    {
        // End:0x114
        if(c_Impacts[I].nmMaterialType == PhysicalProperty.MaterialType)
        {
            return c_Impacts[I];
        }
        I++;
        // [Loop Continue]
        goto J0x9F;
    }
    return c_EmptyImpact;
    //return ReturnValue;    
}

function ApplyImpact(Actor Instigator, Actor HitActor, Vector HitLocation, Vector HitNormal, optional IMPACT_FX Impact)
{
    local editinline MeshComponent HitComponent;

    // End:0x46
    if(Impact == c_EmptyImpact && c_Impacts.Length > 0)
    {
        Impact = c_Impacts[0];
    }
    // End:0x273
    if(Impact.DecalMaterial != none)
    {
        // End:0xBF
        if(HitActor.IsA('TgDestructible'))
        {
            HitComponent = TgDestructible(HitActor).SkeletalMeshComponent;            
        }
        else
        {
            // End:0x116
            if(HitActor.IsA('StaticMeshActor'))
            {
                HitComponent = StaticMeshActor(HitActor).StaticMeshComponent;                
            }
            else
            {
                // End:0x16A
                if(HitActor.IsA('SkeletalMeshActor'))
                {
                    HitComponent = SkeletalMeshActor(HitActor).SkeletalMeshComponent;
                }
            }
        }
        HitActor.WorldInfo.MyDecalManager.SpawnDecal(true, Impact.DecalMaterial, HitLocation, Rotator(-HitNormal), Impact.fDecalWidth, Impact.fDecalHeight, 10.0000000, false, ((Impact.bRandomRotation) ? FRand() * 360.0000000 : 0.0000000), HitComponent, true, true, 'None', -1, 0);
    }
    // End:0x2B7
    if(!c_bAlignToSurfaceNormal)
    {
        HitNormal = Normal(HitLocation - Instigator.Location);
    }
    // End:0x5AE
    if(Impact.SpecialFx != none)
    {
        // End:0x372
        if((HitActor != none) && HitComponent != none)
        {
            Impact.SpecialFx.c_OwnerMesh = HitComponent;
            Impact.SpecialFx.c_Owner = HitActor;            
        }
        else
        {
            // End:0x4F2
            if(Instigator != none)
            {
                // End:0x43B
                if(Instigator.IsA('TgProjectile'))
                {
                    Impact.SpecialFx.c_OwnerMesh = TgProjectile(Instigator).c_Mesh;
                    Impact.SpecialFx.c_Owner = Instigator;                    
                }
                else
                {
                    // End:0x4F2
                    if(Instigator.IsA('TgPawn'))
                    {
                        Impact.SpecialFx.c_OwnerMesh = TgPawn(Instigator).Mesh;
                        Impact.SpecialFx.c_Owner = Instigator;
                    }
                }
            }
        }
        Impact.SpecialFx.SpawnEmitter(HitLocation, HitNormal);
        Impact.SpecialFx.c_Owner = HitActor;
        Impact.SpecialFx.PlaySoundAt(HitLocation);
    }
    return;
    //return;    
}

defaultproperties
{
    c_EmptyImpact=(nmMaterialType="None",Sound=none,DecalMaterial=none,fDecalWidth=0.0000000,fDecalHeight=0.0000000,bRandomRotation=true,Particles=none,SpecialFx=none)
}
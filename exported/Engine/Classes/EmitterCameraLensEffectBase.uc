class EmitterCameraLensEffectBase extends Emitter
    abstract
    native(Particle)
    placeable
    hidecategories(Navigation);

var protected ParticleSystem PS_CameraEffect;
var protected ParticleSystem PS_CameraEffectNonExtremeContent;
var float BaseFOV;
var() protected const float DistFromCamera;
var() protectedwrite const bool bAllowMultipleInstances;
var array< Class<EmitterCameraLensEffectBase> > EmittersToTreatAsSame;
var protected transient Camera BaseCamera;

function Destroyed()
{
    // End:0x2F
    if(BaseCamera != none)
    {
        BaseCamera.RemoveCameraLensEffect(self);
    }
    super(Actor).Destroyed();
    //return;    
}

function RegisterCamera(Camera C)
{
    BaseCamera = C;
    //return;    
}

function NotifyRetriggered()
{
    //return;    
}

simulated function PostBeginPlay()
{
    ParticleSystemComponent.SetDepthPriorityGroup(4);
    super.PostBeginPlay();
    ActivateLensEffect();
    //return;    
}

simulated function ActivateLensEffect()
{
    local ParticleSystem PSToActuallySpawn;

    // End:0xB5
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x76
        if(WorldInfo.GRI.ShouldShowGore())
        {
            PSToActuallySpawn = PS_CameraEffect;            
        }
        else
        {
            PSToActuallySpawn = PS_CameraEffectNonExtremeContent;
        }
        // End:0xB5
        if(PSToActuallySpawn != none)
        {
            SetTemplate(PS_CameraEffect, bDestroyOnSystemFinish);
        }
    }
    //return;    
}

// Export UEmitterCameraLensEffectBase::execUpdateLocation(FFrame&, void* const)
native simulated function UpdateLocation(const out Vector CamLoc, const out Rotator CamRot, float CamFOVDeg);

defaultproperties
{
    BaseFOV=80.0000000
    DistFromCamera=90.0000000
    // Reference: ParticleSystemComponent'Engine.Default__EmitterCameraLensEffectBase.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'Engine.Default__Emitter.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        SecondsBeforeInactive=0.0000000
        ReplacementPrimitive=none
        bOnlyOwnerSee=true
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    bDestroyOnSystemFinish=true
    Components[0]=ParticleSystemComponent0
    TickGroup=ETickingGroup.TG_PostAsyncWork
    bNoDelete=false
    bNetInitialRotation=true
    LifeSpan=10.0000000
}
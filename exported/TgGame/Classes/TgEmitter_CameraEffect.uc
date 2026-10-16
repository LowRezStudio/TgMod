class TgEmitter_CameraEffect extends TgEmitter
    native(FX)
    hidecategories(Navigation);

var() protected float m_fDistFromCamera;
var() bool m_bShowOnlyIn1P;
var bool m_bIsIn1P;
var bool m_bIsCameraEffectActive;
var array<Fx_Sound> m_SoundList;

function Destroyed()
{
    local TgPlayerCamera CameraOwner;

    CameraOwner = TgPlayerCamera(Owner);
    // End:0x4B
    if(CameraOwner != none)
    {
        CameraOwner.RemoveCameraEffect(self);
    }
    super(Actor).Destroyed();
    //return;    
}

simulated function Activate()
{
    super(Emitter).Activate();
    m_bIsCameraEffectActive = true;
    PlaySounds();
    //return;    
}

simulated function Deactivate()
{
    super(Emitter).Deactivate();
    m_bIsCameraEffectActive = false;
    StopSounds();
    //return;    
}

simulated event Reactivate()
{
    // End:0x17
    if(m_bIsCameraEffectActive)
    {
        Deactivate();
    }
    Activate();
    //return;    
}

simulated event SetCameraEffectActive(bool bActive)
{
    // End:0x3D
    if(bActive != m_bIsCameraEffectActive)
    {
        // End:0x33
        if(bActive)
        {
            Activate();            
        }
        else
        {
            Deactivate();
        }
    }
    //return;    
}

simulated function SetSoundList(array<Fx_Sound> SoundList)
{
    m_SoundList = SoundList;
    //return;    
}

// Export UTgEmitter_CameraEffect::execPlaySounds(FFrame&, void* const)
native simulated function PlaySounds();

// Export UTgEmitter_CameraEffect::execStopSounds(FFrame&, void* const)
native simulated function StopSounds();

// Export UTgEmitter_CameraEffect::execUpdateLocation(FFrame&, void* const)
native function UpdateLocation(const out Vector CamLoc, const out Rotator CamRot, float CamFOVDeg);

defaultproperties
{
    m_fDistFromCamera=225.0000000
    m_bShowOnlyIn1P=true
    m_bIsIn1P=true
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitter.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        ReplacementPrimitive=none
        DepthPriorityGroup=ESceneDepthPriorityGroup.SDPG_Foreground
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    bDestroyOnSystemFinish=false
    Components[0]=ParticleSystemComponent0
    LifeSpan=0.0000000
}
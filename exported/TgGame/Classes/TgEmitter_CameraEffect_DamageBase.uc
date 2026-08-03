class TgEmitter_CameraEffect_DamageBase extends TgEmitter_CameraEffect
    abstract
    native(FX)
    hidecategories(Navigation);

enum EDamageEffectScreenLocation
{
    DESL_Right,                     // 0
    DESL_TopRight,                  // 1
    DESL_Top,                       // 2
    DESL_TopLeft,                   // 3
    DESL_Left,                      // 4
    DESL_BottomLeft,                // 5
    DESL_Bottom,                    // 6
    DESL_BottomRight,               // 7
    DESL_MAX                        // 8
};

var const TgEmitter_CameraEffect_DamageBase.EDamageEffectScreenLocation ScreenLocation;

function SetDamageIntensity(float fDamageIntensity, bool bCritical)
{
    fDamageIntensity = FClamp(fDamageIntensity, 0.0000000, 1.0000000);
    ParticleSystemComponent.SetFloatParameter('Crit', ((bCritical) ? 1.0000000 : 0.0000000));
    ParticleSystemComponent.SetFloatParameter('Intensity', fDamageIntensity);
    //return;    
}

simulated function Activate()
{
    // End:0x85
    if(ParticleSystemComponent != none)
    {
        // End:0x52
        if(!ParticleSystemComponent.bWasDeactivated)
        {
            ParticleSystemComponent.DeactivateSystem();
        }
        ParticleSystemComponent.ActivateSystem();
        LifeSpan = default.LifeSpan;
    }
    //return;    
}

// Export UTgEmitter_CameraEffect_DamageBase::execUpdateLocation(FFrame&, void* const)
native function UpdateLocation(const out Vector CamLoc, const out Rotator CamRot, float CamFOVDeg);

defaultproperties
{
    m_fDistFromCamera=500.0000000
    m_bShowOnlyIn1P=false
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect_DamageBase.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        bAutoActivate=false
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    Components[0]=ParticleSystemComponent0
    LifeSpan=10.0000000
}
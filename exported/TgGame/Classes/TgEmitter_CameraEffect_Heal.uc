class TgEmitter_CameraEffect_Heal extends TgEmitter_CameraEffect
    hidecategories(Navigation);

function SetHealIntensity(float fHealIntensity, bool bCritical)
{
    fHealIntensity = FClamp(fHealIntensity, 0.0000000, 1.0000000);
    ParticleSystemComponent.SetFloatParameter('Intensity', fHealIntensity);
    ParticleSystemComponent.SetFloatParameter('Crit', ((bCritical) ? 1.0000000 : 0.0000000));
    //return;    
}

defaultproperties
{
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect_Heal.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        Template=ParticleSystem'fx_generic_status.Particles.FX_Gen_Stat_Healing_Loop_CAM'
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    Components[0]=ParticleSystemComponent0
}
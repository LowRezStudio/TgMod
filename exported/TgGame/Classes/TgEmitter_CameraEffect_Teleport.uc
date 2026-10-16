class TgEmitter_CameraEffect_Teleport extends TgEmitter_CameraEffect
    hidecategories(Navigation);

defaultproperties
{
    m_bShowOnlyIn1P=false
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect_Teleport.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        Template=ParticleSystem'FX_Generic_Combat.Particles.FX_Gen_Cbt_Teleported_A_CAM'
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    bDestroyOnSystemFinish=true
    Components[0]=ParticleSystemComponent0
}
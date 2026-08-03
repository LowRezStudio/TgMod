class TgEmitter_CameraEffect_DamageTop extends TgEmitter_CameraEffect_DamageBase
    hidecategories(Navigation);

defaultproperties
{
    ScreenLocation=EDamageEffectScreenLocation.DESL_Top
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect_DamageTop.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect_DamageBase.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        Template=ParticleSystem'FX_Generic_Combat.Particles.FX_Gen_Cbt_Screen_Hit_Top_CAM'
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    Components[0]=ParticleSystemComponent0
}
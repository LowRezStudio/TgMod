class TgEmitter_CameraEffect_Stun extends TgEmitter_CameraEffect
    hidecategories(Navigation);

defaultproperties
{
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect_Stun.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        Template=ParticleSystem'fx_generic_status.Particles.FX_Gen_Stat_Stun_CAM'
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    Components[0]=ParticleSystemComponent0
}
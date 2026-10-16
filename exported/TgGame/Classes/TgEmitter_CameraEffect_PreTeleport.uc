class TgEmitter_CameraEffect_PreTeleport extends TgEmitter_CameraEffect
    hidecategories(Navigation);

defaultproperties
{
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect_PreTeleport.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        Template=ParticleSystem'FX_NPC_Beacon.Particles.FX_In_Phasing_To_Out_CAM_A'
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    bDestroyOnSystemFinish=true
    Components[0]=ParticleSystemComponent0
}
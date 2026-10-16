class TgEmitter_CameraEffect_Hidden extends TgEmitter_CameraEffect
    hidecategories(Navigation);

simulated function ChangeTemplate(ParticleSystem NewTemplate)
{
    // End:0x37
    if(NewTemplate == none)
    {
        NewTemplate = default.ParticleSystemComponent.Template;
    }
    // End:0x9C
    if((ParticleSystemComponent != none) && ParticleSystemComponent.Template != NewTemplate)
    {
        ParticleSystemComponent.SetTemplate(NewTemplate);
    }
    //return;    
}

defaultproperties
{
    m_bShowOnlyIn1P=false
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect_Hidden.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitter_CameraEffect.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        Template=ParticleSystem'FX_Env_Atmosphere.Particles.FX_Hidden_1P_CAM'
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    Components[0]=ParticleSystemComponent0
}
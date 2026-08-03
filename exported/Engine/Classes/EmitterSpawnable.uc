class EmitterSpawnable extends Emitter
    notplaceable
    hidecategories(Navigation);

var repnotify ParticleSystem ParticleTemplate;

replication
{
    // Pos:0x000
    if(bNetInitial)
        ParticleTemplate;
}

simulated event SetTemplate(ParticleSystem NewTemplate, optional bool bDestroyOnFinish)
{
    super.SetTemplate(NewTemplate, bDestroyOnFinish);
    ParticleTemplate = NewTemplate;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x78
    if(VarName == 'ParticleTemplate')
    {
        SetTemplate(ParticleTemplate, bDestroyOnSystemFinish);
        ParticleSystemComponent.ActivateSystem();
        // End:0x75
        if((ParticleTemplate == none) && bDestroyOnSystemFinish)
        {
            Destroy();
        }        
    }
    else
    {
        super.ReplicatedEvent(VarName);
    }
    //return;    
}

defaultproperties
{
    // Reference: ParticleSystemComponent'Engine.Default__EmitterSpawnable.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'Engine.Default__Emitter.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        SecondsBeforeInactive=0.0000000
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    bDestroyOnSystemFinish=true
    Components[0]=none
    Components[1]=ParticleSystemComponent0
    Components[2]=none
    bNoDelete=false
    bNetTemporary=true
}
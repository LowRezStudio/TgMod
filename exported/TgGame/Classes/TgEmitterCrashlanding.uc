class TgEmitterCrashlanding extends TgEmitterSpawnable
    hidecategories(Navigation);

var export editinline StaticMeshComponent m_PrimaryMesh;
var export editinline StaticMeshComponent m_SecondaryMesh;
var float ParticleDurationAfterImpact;
var export editinline LensFlareComponent m_LensFlare;
var export editinline AudioComponent m_AudioComponent;

simulated function SetPrimaryMesh(StaticMesh StaticMeshToSet)
{
    m_PrimaryMesh.SetStaticMesh(StaticMeshToSet);
    //return;    
}

simulated function SetSecondaryMesh(StaticMesh StaticMeshToSet)
{
    m_SecondaryMesh.SetStaticMesh(StaticMeshToSet);
    //return;    
}

simulated function SetAudio(SoundCue SoundCueToSet)
{
    // End:0x56
    if(m_AudioComponent != none)
    {
        m_AudioComponent.SoundCue = SoundCueToSet;
        m_AudioComponent.Play();
    }
    //return;    
}

simulated function OnImpact()
{
    m_PrimaryMesh.SetHidden(true);
    m_SecondaryMesh.SetHidden(true);
    m_LensFlare.SetHidden(true);
    // End:0x8D
    if(ParticleDurationAfterImpact != 0.0000000)
    {
        SetTimer(ParticleDurationAfterImpact, false, 'PostImpactComplete');        
    }
    else
    {
        PostImpactComplete();
    }
    //return;    
}

simulated function PostImpactComplete()
{
    // End:0x2E
    if(ParticleSystemComponent != none)
    {
        ParticleSystemComponent.DeactivateSystem();
    }
    // End:0x5D
    if(m_AudioComponent != none)
    {
        m_AudioComponent.Stop();
    }
    bCurrentlyActive = false;
    LifeSpan = 2.0000000;
    //return;    
}

defaultproperties
{
    // Reference: StaticMeshComponent'TgGame.Default__TgEmitterCrashlanding.Primary'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Primary'
    begin object name="Primary" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
    end object
    m_PrimaryMesh=Primary
    // Reference: StaticMeshComponent'TgGame.Default__TgEmitterCrashlanding.Secondary'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Secondary'
    begin object name="Secondary" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
    end object
    m_SecondaryMesh=Secondary
    ParticleDurationAfterImpact=5.0000000
    // Reference: LensFlareComponent'TgGame.Default__TgEmitterCrashlanding.LF'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'LF'
    begin object name="LF" class=Engine.LensFlareComponent
        ReplacementPrimitive=none
    end object
    m_LensFlare=LF
    // Reference: AudioComponent'TgGame.Default__TgEmitterCrashlanding.AC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AC'
    begin object name="AC" class=Engine.AudioComponent
        bStopWhenOwnerDestroyed=true
        bShouldRemainActiveIfDropped=true
    end object
    m_AudioComponent=AC
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitterCrashlanding.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'TgGame.Default__TgEmitterSpawnable.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    Components[0]=none
    Components[1]=ParticleSystemComponent0
    Components[2]=none
    Components[3]=Primary
    Components[4]=Secondary
    Components[5]=LF
    Components[6]=AC
}
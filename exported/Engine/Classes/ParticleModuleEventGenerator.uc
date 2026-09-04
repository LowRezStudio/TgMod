class ParticleModuleEventGenerator extends ParticleModuleEventBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

struct native ParticleEvent_GenerateInfo
{
    var() ParticleSystemComponent.EParticleEventType Type;
    var() int Frequency;
    var() int LowFreq;
    var() int ParticleFrequency;
    var() bool FirstTimeOnly;
    var() bool LastTimeOnly;
    var() bool UseReflectedImpactVector;
    var() name CustomName;
    var() editinline array<editinline ParticleModuleEventSendToGame> ParticleModuleEventsToSendToGame;

    structdefaultproperties
    {
        Type=EParticleEventType.EPET_Any
        Frequency=0
        LowFreq=-1
        ParticleFrequency=0
        FirstTimeOnly=false
        LastTimeOnly=false
        UseReflectedImpactVector=false
        CustomName="None"
        ParticleModuleEventsToSendToGame=none
    }
};

var(Events) noclear export array<export ParticleEvent_GenerateInfo> Events;

defaultproperties
{
    bSpawnModule=true
    bUpdateModule=true
}
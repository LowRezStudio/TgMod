class TgEmitter_TeamColor extends Emitter
    native(FX)
    hidecategories(Navigation);

var() int nTaskForce;
var() ParticleChannelContainer DefaultParticleChannels;

// Export UTgEmitter_TeamColor::execSetPSCChannels(FFrame&, void* const)
native function SetPSCChannels();

simulated function NotifyLocalPlayerTeamReceived()
{
    super(Actor).NotifyLocalPlayerTeamReceived();
    SetPSCChannels();
    //return;    
}

defaultproperties
{
    DefaultParticleChannels=(bInitialized=true,Default=true,Friendly=true,Enemy=false,LocalOwner=false,Channel5=false,Channel6=false,Channel7=false,Channel8=false,VerticalTargeter=false,Filter2=false,NotLocalOwner=false,CustomFilter1=false,CustomFilter2=false,CustomFilter3=false,CustomFilter4=false,CustomFilter5=false,CustomFilter6=false,CustomFilter7=false)
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter_TeamColor.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'Engine.Default__Emitter.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    Components[0]=none
    Components[1]=ParticleSystemComponent0
    Components[2]=none
}
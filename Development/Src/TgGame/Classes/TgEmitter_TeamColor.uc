class TgEmitter_TeamColor extends Emitter
    native(FX)
    hidecategories(Navigation)
    config(Engine);

var () int nTaskForce;
var () ParticleChannelContainer DefaultParticleChannels;

native function SetPSCChannels();  // Export UTgEmitter_TeamColor::execSetPSCChannels(FFrame&, void* const)

simulated function NotifyLocalPlayerTeamReceived() { }

defaultproperties
{}

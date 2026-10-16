class InterpTrackParticleReplay extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct native ParticleReplayTrackKey
{
    var float Time;
    var() float Duration;
    var() int ClipIDNumber;

    structdefaultproperties
    {
        Time=0.0000000
        Duration=0.0000000
        ClipIDNumber=0
    }
};

var editinline array<editinline ParticleReplayTrackKey> TrackKeys;
var editoronly const transient bool bIsCapturingReplay;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstParticleReplay'
    TrackTitle="Particle Replay"
}
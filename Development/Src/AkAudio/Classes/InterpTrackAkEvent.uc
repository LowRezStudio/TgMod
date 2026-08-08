class InterpTrackAkEvent extends InterpTrack
    native
    collapsecategories
    hidecategories(Object)
    config(Engine);

struct AkEventTrackKey {
    var float Time;
    var () AkEvent Event;
    structdefaultproperties {}
};

var array<AkEventTrackKey> AkEvents;

defaultproperties
{
    TrackInstClass=Class'InterpTrackInstAkEvent'
    TrackTitle="AkEvent"
}

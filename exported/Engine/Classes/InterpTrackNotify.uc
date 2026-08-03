class InterpTrackNotify extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct native NotifyTrackKey
{
    var float Time;
    var AnimNotify Notify;

    structdefaultproperties
    {
        Time=0.0000000
        Notify=none
    }
};

var AnimNodeSequence Node;
var name ParentNodeName;
var AnimSequence OuterSequence;
var AnimSet OuterSet;
var array<NotifyTrackKey> NotifyTrack;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstNotify'
    TrackTitle="Notify"
}
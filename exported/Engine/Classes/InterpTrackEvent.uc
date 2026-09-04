class InterpTrackEvent extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct native EventTrackKey
{
    var float Time;
    var() name EventName;

    structdefaultproperties
    {
        Time=0.0000000
        EventName="None"
    }
};

var array<EventTrackKey> EventTrack;
var() bool bFireEventsWhenForwards;
var() bool bFireEventsWhenBackwards;
var() bool bFireEventsWhenJumpingForwards;

defaultproperties
{
    bFireEventsWhenForwards=true
    bFireEventsWhenBackwards=true
    TrackInstClass=Class'Engine.InterpTrackInstEvent'
    TrackTitle="Event"
}
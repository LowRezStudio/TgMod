class InterpTrackVisibility extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

enum EVisibilityTrackAction
{
    EVTA_Hide,                      // 0
    EVTA_Show,                      // 1
    EVTA_Toggle,                    // 2
    EVTA_MAX                        // 3
};

enum EVisibilityTrackCondition
{
    EVTC_Always,                    // 0
    EVTC_GoreEnabled,               // 1
    EVTC_GoreDisabled,              // 2
    EVTC_MAX                        // 3
};

struct native VisibilityTrackKey
{
    var float Time;
    var() InterpTrackVisibility.EVisibilityTrackAction Action;
    var InterpTrackVisibility.EVisibilityTrackCondition ActiveCondition;

    structdefaultproperties
    {
        Time=0.0000000
        Action=EVisibilityTrackAction.EVTA_Hide
        ActiveCondition=EVisibilityTrackCondition.EVTC_Always
    }
};

var array<VisibilityTrackKey> VisibilityTrack;
var() bool bFireEventsWhenForwards;
var() bool bFireEventsWhenBackwards;
var() bool bFireEventsWhenJumpingForwards;

defaultproperties
{
    bFireEventsWhenForwards=true
    bFireEventsWhenBackwards=true
    bFireEventsWhenJumpingForwards=true
    TrackInstClass=Class'Engine.InterpTrackInstVisibility'
    TrackTitle="Visibility"
}
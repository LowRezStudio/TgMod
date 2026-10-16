class InterpTrackToggle extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

enum ETrackToggleAction
{
    ETTA_Off,                       // 0
    ETTA_On,                        // 1
    ETTA_Toggle,                    // 2
    ETTA_Trigger,                   // 3
    ETTA_MAX                        // 4
};

struct native ToggleTrackKey
{
    var float Time;
    var() InterpTrackToggle.ETrackToggleAction ToggleAction;

    structdefaultproperties
    {
        Time=0.0000000
        ToggleAction=ETrackToggleAction.ETTA_Off
    }
};

var array<ToggleTrackKey> ToggleTrack;
var() bool bActivateSystemEachUpdate;
var() bool bActivateWithJustAttachedFlag;
var() bool bFireEventsWhenForwards;
var() bool bFireEventsWhenBackwards;
var() bool bFireEventsWhenJumpingForwards;

defaultproperties
{
    bActivateWithJustAttachedFlag=true
    bFireEventsWhenForwards=true
    bFireEventsWhenBackwards=true
    bFireEventsWhenJumpingForwards=true
    TrackInstClass=Class'Engine.InterpTrackInstToggle'
    TrackTitle="Toggle"
}
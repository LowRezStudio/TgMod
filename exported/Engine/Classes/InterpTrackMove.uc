class InterpTrackMove extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

enum EInterpTrackMoveFrame
{
    IMF_World,                      // 0
    IMF_RelativeToInitial,          // 1
    IMF_MAX                         // 2
};

enum EInterpTrackMoveRotMode
{
    IMR_Keyframed,                  // 0
    IMR_LookAtGroup,                // 1
    IMR_Ignore,                     // 2
    IMR_MAX                         // 3
};

struct native InterpLookupPoint
{
    var name GroupName;
    var float Time;

    structdefaultproperties
    {
        GroupName="None"
        Time=0.0000000
    }
};

struct native InterpLookupTrack
{
    var array<InterpLookupPoint> Points;

    structdefaultproperties
    {
        Points=none
    }
};

var InterpCurveVector PosTrack;
var InterpCurveVector EulerTrack;
var InterpLookupTrack LookupTrack;
var() name LookAtGroupName;
var() float LinCurveTension;
var() float AngCurveTension;
var() bool bUseQuatInterpolation;
var() bool bShowArrowAtKeys;
var() bool bDisableMovement;
var() bool bShowTranslationOnCurveEd;
var() bool bShowRotationOnCurveEd;
var() bool bHide3DTrack;
var() bool bUseRawActorTMforRelativeToInitial;
var() editconst InterpTrackMove.EInterpTrackMoveFrame MoveFrame;
var() InterpTrackMove.EInterpTrackMoveRotMode RotMode;

defaultproperties
{
    bShowTranslationOnCurveEd=true
    TrackInstClass=Class'Engine.InterpTrackInstMove'
    TrackTitle="Movement"
    bOnePerGroup=true
}
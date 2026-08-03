class InterpTrackMoveAxis extends InterpTrackFloatBase
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

enum EInterpMoveAxis
{
    AXIS_TranslationX,              // 0
    AXIS_TranslationY,              // 1
    AXIS_TranslationZ,              // 2
    AXIS_RotationX,                 // 3
    AXIS_RotationY,                 // 4
    AXIS_RotationZ,                 // 5
    AXIS_MAX                        // 6
};

var InterpTrackMoveAxis.EInterpMoveAxis MoveAxis;
var InterpLookupTrack LookupTrack;

defaultproperties
{
    TrackTitle="Move Axis Track"
    bSubTrackOnly=true
}
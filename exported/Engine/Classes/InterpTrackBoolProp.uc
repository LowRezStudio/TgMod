class InterpTrackBoolProp extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct native BoolTrackKey
{
    var float Time;
    var() bool Value;

    structdefaultproperties
    {
        Time=0.0000000
        Value=false
    }
};

var array<BoolTrackKey> BoolTrack;
var() editconst name PropertyName;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstBoolProp'
    TrackTitle="Bool Property"
}
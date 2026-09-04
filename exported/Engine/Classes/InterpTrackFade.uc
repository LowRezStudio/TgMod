class InterpTrackFade extends InterpTrackFloatBase
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

var() bool bPersistFade;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstFade'
    TrackTitle="Fade"
    bOnePerGroup=true
    bDirGroupOnly=true
}
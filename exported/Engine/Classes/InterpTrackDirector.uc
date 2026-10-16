class InterpTrackDirector extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct native DirectorTrackCut
{
    var float Time;
    var float TransitionTime;
    var() name TargetCamGroup;
    var int ShotNumber;

    structdefaultproperties
    {
        Time=0.0000000
        TransitionTime=0.0000000
        TargetCamGroup="None"
        ShotNumber=0
    }
};

var array<DirectorTrackCut> CutTrack;
var() bool bSimulateCameraCutsOnClients;
var() float fIntroFadeTime;
var() float fOutroFadeTime;

defaultproperties
{
    bSimulateCameraCutsOnClients=true
    fIntroFadeTime=0.5000000
    TrackInstClass=Class'Engine.InterpTrackInstDirector'
    TrackTitle="Director"
    bOnePerGroup=true
    bDirGroupOnly=true
}
class InterpTrackAnimControl extends InterpTrackFloatBase
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct native AnimControlTrackKey
{
    var float StartTime;
    var name AnimSeqName;
    var float AnimStartOffset;
    var float AnimEndOffset;
    var float AnimPlayRate;
    var bool bLooping;
    var bool bReverse;

    structdefaultproperties
    {
        StartTime=0.0000000
        AnimSeqName="None"
        AnimStartOffset=0.0000000
        AnimEndOffset=0.0000000
        AnimPlayRate=0.0000000
        bLooping=false
        bReverse=false
    }
};

var array<AnimSet> AnimSets;
var() name SlotName;
var array<AnimControlTrackKey> AnimSeqs;
var() bool bEnableRootMotion;
var() bool bSkipAnimNotifiers;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstAnimControl'
    TrackTitle="Anim"
    bIsAnimControlTrack=true
}
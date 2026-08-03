class InterpTrackFaceFX extends InterpTrack
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct native FaceFXTrackKey
{
    var float StartTime;
    var string FaceFXGroupName;
    var string FaceFXSeqName;

    structdefaultproperties
    {
        StartTime=0.0000000
        FaceFXGroupName=""
        FaceFXSeqName=""
    }
};

struct native FaceFXSoundCueKey
{
    var private const SoundCue FaceFXSoundCue;
    var private const AkEvent FaceFXAkEvent;

    structdefaultproperties
    {
        FaceFXSoundCue=none
        FaceFXAkEvent=none
    }
};

var() array<FaceFXAnimSet> FaceFXAnimSets;
var array<FaceFXTrackKey> FaceFXSeqs;
var transient FaceFXAsset CachedActorFXAsset;
var private const array<FaceFXSoundCueKey> FaceFXSoundCueKeys;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstFaceFX'
    TrackTitle="FaceFX"
    bOnePerGroup=true
}
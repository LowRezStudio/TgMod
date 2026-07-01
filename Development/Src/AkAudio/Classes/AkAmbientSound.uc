class AkAmbientSound extends Keypoint
    native
    hidecategories(Navigation);

var bool bAutoPlay;
var() bool StopWhenOwnerIsDestroyed;
var private transient bool bIsPlaying;
var() AkEvent PlayEvent;

// Export UAkAmbientSound::execStartPlayback(FFrame&, void* const)
native function StartPlayback();

// Export UAkAmbientSound::execStopPlayback(FFrame&, void* const)
native function StopPlayback();

defaultproperties
{
    bAutoPlay=true
    StopWhenOwnerIsDestroyed=true
}
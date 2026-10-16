class AkAmbientSound extends Keypoint
    native
    hidecategories(Navigation)
    config(Engine);

var bool bAutoPlay;
var () bool StopWhenOwnerIsDestroyed;
var private transient bool bIsPlaying;
var () AkEvent PlayEvent;

defaultproperties
{
    bAutoPlay=true
    StopWhenOwnerIsDestroyed=true
}

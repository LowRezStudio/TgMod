class AkAmbientSound extends Keypoint
    native
    hidecategories(Navigation);

var bool bAutoPlay;
var() bool StopWhenOwnerIsDestroyed;
var private transient bool bIsPlaying;
var() AkEvent PlayEvent;

defaultproperties
{
    bAutoPlay=true
    StopWhenOwnerIsDestroyed=true
}
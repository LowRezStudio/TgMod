class SoundNodeLooping extends SoundNode
    native(Sound)
    editinlinenew
    hidecategories(Object,Object);

var(Looping) bool bLoopIndefinitely;
var(Looping) float LoopCountMin;
var(Looping) float LoopCountMax;
var deprecated RawDistributionFloat LoopCount;

defaultproperties
{
    bLoopIndefinitely=true
    LoopCountMin=1000000.0000000
    LoopCountMax=1000000.0000000
}
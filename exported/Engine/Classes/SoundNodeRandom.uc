class SoundNodeRandom extends SoundNode
    native(Sound)
    editinlinenew
    hidecategories(Object,Object);

var() editfixedsize array<float> Weights;
var() int PreselectAtLevelLoad;
var() bool bRandomizeWithoutReplacement;
var transient array<bool> HasBeenUsed;
var transient int NumRandomUsed;

defaultproperties
{
    bRandomizeWithoutReplacement=true
}
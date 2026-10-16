class TgAnimNodeSelfDestruct extends TgAnimNodeSequence
    native(Anim)
    hidecategories(Object,Object,Object);

var(SelfDestruct) int NumberOfLoopsBeforeDestruct;
var int LoopsCompleted;
var(ScaleOut) array<name> ScaleOutSkelControlNames;
var(ScaleOut) float TimeRemaingForScaleOut;
var transient array<SkelControlBase> ScaleOutSkelControls;
var transient array<float> ScaleOutStartScales;
var transient float ScaleOutStartTime;

defaultproperties
{
    NumberOfLoopsBeforeDestruct=1
    ScaleOutStartTime=-1.0000000
}
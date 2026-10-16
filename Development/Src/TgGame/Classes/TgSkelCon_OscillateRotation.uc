class TgSkelCon_OscillateRotation extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

var () float OscillationAmplitude;
var () float OscillationFrequency;
var () Vector OscillationAxis;
var () SkelControlBase.EBoneControlSpace OscillationAxisSpace;
var () name OscillationAxisSpaceBoneName;
var transient float Theta;

defaultproperties
{
    OscillationAmplitude=1.0000000
    OscillationFrequency=1.0000000
    OscillationAxis=(X=0.0000000,Y=0.0000000,Z=1.0000000)
}

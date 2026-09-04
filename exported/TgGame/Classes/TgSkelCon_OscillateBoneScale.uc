class TgSkelCon_OscillateBoneScale extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object);

var() float OscillationAmplitude;
var() float OscillationFrequency;
var() float OscillationBaseScale;
var transient float Theta;

defaultproperties
{
    OscillationAmplitude=0.5000000
    OscillationFrequency=1.0000000
    OscillationBaseScale=1.0000000
}
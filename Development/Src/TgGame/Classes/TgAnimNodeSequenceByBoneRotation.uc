class TgAnimNodeSequenceByBoneRotation extends AnimNodeSequence
    hidecategories(Object,Object,Object)
    config(Engine);

struct AnimByRotation {
    var () Rotator DesiredRotation;
    var () name AnimName;
    structdefaultproperties {}
};

var () name BoneName;
var () Object.EAxis BoneAxis;
var () array<AnimByRotation> AnimList;

event OnBecomeRelevant() { }

defaultproperties
{
    BoneAxis=AXIS_X
}

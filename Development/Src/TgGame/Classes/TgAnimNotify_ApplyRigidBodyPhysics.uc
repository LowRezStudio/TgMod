class TgAnimNotify_ApplyRigidBodyPhysics extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

var () bool ShouldAttachToBone;
var () name BoneName;
var () Vector ImpulseLocation;
var () float ImpulseRadius;
var () float ImpulseStrength;

defaultproperties
{
    ImpulseRadius=100.0000000
    ImpulseStrength=100.0000000
    ShouldDeferIssue=true
}

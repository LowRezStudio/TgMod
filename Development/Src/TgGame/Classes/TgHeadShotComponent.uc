class TgHeadShotComponent extends CylinderComponent
    native(Pawns)
    editinlinenew
    collapsecategories
    config(Engine);

var export editinline TgSkeletalMeshComponent m_SkelComp;
var name m_HeadBone;
var Vector m_vHeadOffset;

defaultproperties
{
    ReplacementPrimitive=none
    CollideActors=true
    BlockNonZeroExtent=false
}

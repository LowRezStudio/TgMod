class TgSkelControlSingleBone_PistonBarrel extends TgSkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object);

var float m_nDepressDistance;
var float m_nReturnSpeed;

// Export UTgSkelControlSingleBone_PistonBarrel::execDepress(FFrame&, void* const)
native function Depress();

defaultproperties
{
    m_nDepressDistance=15.0000000
    m_nReturnSpeed=100.0000000
    BoneTranslationSpace=EBoneControlSpace.BCS_BoneSpace
}
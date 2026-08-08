class TgSkelControlSingleBone_PistonBarrel extends TgSkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

var float m_nDepressDistance;
var float m_nReturnSpeed;

native function Depress();  // Export UTgSkelControlSingleBone_PistonBarrel::execDepress(FFrame&, void* const)

defaultproperties
{
    m_nDepressDistance=15.0000000
    m_nReturnSpeed=100.0000000
    BoneTranslationSpace=BCS_BoneSpace
}

class TgSkelCon_HookChain extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object);

const TGSKELCON_HOOKCHAIN_TOTALSEGMENTS = 72;
const TGSKELCON_HOOKCHAIN_STARTOFFSET = 4;

var float m_fBoneScales[72];
var TgDeviceForm_Drag m_DragDeviceForm;
var export editinline TgSkeletalMeshComponent m_ChainComponent;

simulated event float GetAngleToBone(int BoneIndex)
{
    local Vector toBone, toRootBone, BoneLocation, rootBoneLocation, SocketLocation;

    // End:0x13B
    if((m_ChainComponent != none) && m_DragDeviceForm != none)
    {
        SocketLocation = m_DragDeviceForm.GetChainSocketLocation();
        BoneLocation = m_ChainComponent.GetBoneLocation(m_ChainComponent.GetBoneName(BoneIndex), 0);
        rootBoneLocation = m_ChainComponent.GetBoneLocation(m_ChainComponent.GetBoneName(4), 0);
        toBone = Normal(BoneLocation - SocketLocation);
        toRootBone = Normal(rootBoneLocation - SocketLocation);
        return toBone Dot toRootBone;
    }
    return -1.0000000;
    //return ReturnValue;    
}

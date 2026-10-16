class TgSkelCon_HookChain extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

const TGSKELCON_HOOKCHAIN_TOTALSEGMENTS = 72;

const TGSKELCON_HOOKCHAIN_STARTOFFSET = 4;

var float m_fBoneScales[72];
var TgDeviceForm_Drag m_DragDeviceForm;
var export editinline TgSkeletalMeshComponent m_ChainComponent;

simulated event float GetAngleToBone(int BoneIndex) { }

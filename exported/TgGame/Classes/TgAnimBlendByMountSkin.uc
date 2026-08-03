class TgAnimBlendByMountSkin extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native MountSkinChildInfo
{
    var() int nMountSkinId;
    var() int nChildIndex;

    structdefaultproperties
    {
        nMountSkinId=0
        nChildIndex=0
    }
};

var() array<MountSkinChildInfo> m_SkinMap;

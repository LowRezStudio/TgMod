class TgAnimBlendBySkin extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native SkinChildInfo
{
    var() int nSkinId;
    var() int nChildIndex;

    structdefaultproperties
    {
        nSkinId=0
        nChildIndex=0
    }
};

var() array<SkinChildInfo> m_SkinMap;

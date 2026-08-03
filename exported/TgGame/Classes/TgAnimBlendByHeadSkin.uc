class TgAnimBlendByHeadSkin extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native HeadSkinChildInfo
{
    var() int nHeadSkinId;
    var() int nChildIndex;

    structdefaultproperties
    {
        nHeadSkinId=0
        nChildIndex=0
    }
};

var() array<HeadSkinChildInfo> m_SkinMap;

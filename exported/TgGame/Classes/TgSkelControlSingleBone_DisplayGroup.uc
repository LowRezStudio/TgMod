class TgSkelControlSingleBone_DisplayGroup extends TgSkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object);

enum DisplayGroupOnType
{
    DISPLAYGROUP_ON_INACTIVE,       // 0
    DISPLAYGROUP_ON_ACTIVE,         // 1
    DISPLAYGROUP_ON_STRENGTHABOVE,  // 2
    DISPLAYGROUP_ON_STRENGTHBELOW,  // 3
    DISPLAYGROUP_ON_MAX             // 4
};

struct native DisplayGroupInfo
{
    var() name DisplayGroupName;
    var() TgSkelControlSingleBone_DisplayGroup.DisplayGroupOnType WhenDisplayGroupOn;
    var() float Strength;
    var transient bool bOn;
    var() bool ForceOffIfMeshHidden;

    structdefaultproperties
    {
        DisplayGroupName="None"
        WhenDisplayGroupOn=DisplayGroupOnType.DISPLAYGROUP_ON_INACTIVE
        Strength=0.0000000
        bOn=false
        ForceOffIfMeshHidden=true
    }
};

var() export editinline array<export editinline DisplayGroupInfo> DisplayGroupInfos;

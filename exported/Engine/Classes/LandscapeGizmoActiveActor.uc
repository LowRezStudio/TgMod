class LandscapeGizmoActiveActor extends LandscapeGizmoActor
    native(Terrain)
    notplaceable
    hidecategories(Navigation);

enum ELandscapeGizmoType
{
    LGT_None,                       // 0
    LGT_Height,                     // 1
    LGT_Weight,                     // 2
    LGT_MAX                         // 3
};

struct native GizmoSelectData
{
};

var private native const map{VOID,VOID} SelectedData;

defaultproperties
{
    bEditable=true
}
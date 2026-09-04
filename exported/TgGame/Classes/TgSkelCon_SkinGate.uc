class TgSkelCon_SkinGate extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

struct native SkelControlSkinGateChild
{
    var SkelControlBase SkelControl;
    var() int nSkinId;
    var() int nSkinLevel;
    var editconst transient float DrawY;

    structdefaultproperties
    {
        SkelControl=none
        nSkinId=0
        nSkinLevel=0
        DrawY=0.0000000
    }
};

var SkelControlSkinGateChild DefaultChild;
var(Gate) array<SkelControlSkinGateChild> ChildControls;

defaultproperties
{
    ControlStrength=0.0000000
}
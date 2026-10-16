class TgSkelCon_SkinGate extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

struct SkelControlSkinGateChild {
    var SkelControlBase SkelControl;
    var () int nSkinId;
    var () int nSkinLevel;
    var editconst transient float DrawY;
    structdefaultproperties {}
};

var SkelControlSkinGateChild DefaultChild;
var (Gate) array<SkelControlSkinGateChild> ChildControls;

defaultproperties
{
    ControlStrength=0.0000000
}

class TgSkelCon_Gate extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object)
    config(Engine);

struct SkelControlGateChild {
    var SkelControlBase SkelControl;
    var editconst transient float DrawY;
    structdefaultproperties {}
};

var (Gate) array<SkelControlGateChild> ChildControls;

defaultproperties
{
    ChildControls[0]=(SkelControl=none,DrawY=0.0000000)
    ControlStrength=0.0000000
}

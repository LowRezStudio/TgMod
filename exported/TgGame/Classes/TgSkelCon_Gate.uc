class TgSkelCon_Gate extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

struct native SkelControlGateChild
{
    var SkelControlBase SkelControl;
    var editconst transient float DrawY;

    structdefaultproperties
    {
        SkelControl=none
        DrawY=0.0000000
    }
};

var(Gate) array<SkelControlGateChild> ChildControls;

defaultproperties
{
    ChildControls[0]=(SkelControl=none,DrawY=0.0000000)
    ControlStrength=0.0000000
}
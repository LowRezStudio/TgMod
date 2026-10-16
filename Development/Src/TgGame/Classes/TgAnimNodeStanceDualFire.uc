class TgAnimNodeStanceDualFire extends TgAnimNodeStanceTransitionerSynchronized
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var bool m_bFireParityDirty;
var int m_nDesiredStance;

native function ChangeStance(int Stance, optional bool bAutoSync=true, optional bool bForceUpdate=false);  // Export UTgAnimNodeStanceDualFire::execChangeStance(FFrame&, void* const)

defaultproperties
{
    StanceResetTime=0.0000000
}

class TgAnimNodeStanceDualFire extends TgAnimNodeStanceTransitionerSynchronized
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var bool m_bFireParityDirty;
var int m_nDesiredStance;

// Export UTgAnimNodeStanceDualFire::execChangeStance(FFrame&, void* const)
native function ChangeStance(int Stance, optional bool bAutoSync = true, optional bool bForceUpdate = false);

defaultproperties
{
    StanceResetTime=0.0000000
}
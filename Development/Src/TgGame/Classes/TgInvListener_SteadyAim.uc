class TgInvListener_SteadyAim extends TgInvListener
    native(ChampKinessa)
    config(Engine);

var int m_nSteadyAimStackCount;
var float m_fFullyChargedHitTime;

defaultproperties
{
    m_fFullyChargedHitTime=-1.0000000
}

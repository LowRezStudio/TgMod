class TgDevice_MarkShot extends TgDevice
    native(ChampLex)
    hidecategories(Navigation)
    config(Engine);

var bool m_bRecalculateMark;
var TgPawn_Character m_CurrentMark;

simulated event StartFire(byte FireModeNum) { }

defaultproperties
{
    m_bRecalculateMark=true
}

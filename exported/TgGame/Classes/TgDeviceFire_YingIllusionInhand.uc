class TgDeviceFire_YingIllusionInhand extends TgDeviceFire_WorldLOSOnly
    native(ChampYing);

defaultproperties
{
    m_eTargetSelectionTypeOverride=TargetSelectionType.TGTST_LowestHealthPercent
    m_bPassThroughShield=true
    m_bMaintainBurstTarget=true
}
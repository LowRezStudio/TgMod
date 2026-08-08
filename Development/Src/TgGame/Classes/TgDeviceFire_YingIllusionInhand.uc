class TgDeviceFire_YingIllusionInhand extends TgDeviceFire_WorldLOSOnly
    native(ChampYing)
    config(Engine);

defaultproperties
{
    m_eTargetSelectionTypeOverride=TGTST_LowestHealthPercent
    m_bPassThroughShield=true
    m_bMaintainBurstTarget=true
}

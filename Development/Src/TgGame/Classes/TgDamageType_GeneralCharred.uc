class TgDamageType_GeneralCharred extends TgDamageType
    config(Engine);

defaultproperties
{
    m_bImpulseMesh=false
    m_bEnableMotors=false
    m_nmDeathAnimNames[0]="Death_Charred_01"
    m_nDeathSpecialFXId=2586
    m_nmDeathSpecialFXSocket="CSO_COG"
    m_fLifeAfterDeathSeconds=2.0000000
    m_nFadeOutSpecialFXId=2587
}

class TgDamageType_GeneralOnFire extends TgDamageType
    config(Engine);

defaultproperties
{
    m_bImpulseMesh=false
    m_bEnableMotors=false
    m_nmDeathAnimNames[0]="Death_OnFire_01"
    m_nmDeathAnimNames[1]="Death_OnFire_02"
    m_nDeathSpecialFXId=2585
    m_nmDeathSpecialFXSocket="CSO_COG"
}

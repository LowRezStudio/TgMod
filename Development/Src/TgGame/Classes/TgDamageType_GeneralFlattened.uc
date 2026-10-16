class TgDamageType_GeneralFlattened extends TgDamageType
    config(Engine);

defaultproperties
{
    m_bImpulseMesh=false
    m_bEnableMotors=false
    m_nmDeathAnimNames[0]="Death_Flattened_01"
    m_nmDeathAnimNames[1]="Death_Flattened_02"
    m_nmDeathAnimNames[2]="Death_Flattened_03"
    ActivateSkelControlListOnDeath[0]="Prop1_SC_Lock"
    ActivateSkelControlListOnDeath[1]="Prop2_SC_Lock"
    ActivateSkelControlListOnDeath[2]="FlattenedScaler"
}

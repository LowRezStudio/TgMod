class TgDeviceFire_Tempest extends TgDeviceFire
    native(ChampGrohk)
    config(Engine)
    dependson(TgObject);

native function ImpactInfo CalcAoeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false, optional float RewindTime=0.0000000);  // Export UTgDeviceFire_Tempest::execCalcAoeFire(FFrame&, void* const)

defaultproperties
{
    m_eTargetSelectionTypeOverride=TGTST_Random
    m_bIsAOE=true
    m_bIgnoreDeployablesForBlocking=true
}

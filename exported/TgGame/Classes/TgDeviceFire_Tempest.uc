class TgDeviceFire_Tempest extends TgDeviceFire
    native(ChampGrohk);

// Export UTgDeviceFire_Tempest::execCalcAoeFire(FFrame&, void* const)
native function ImpactInfo CalcAoeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false, optional float RewindTime = 0.0000000);

defaultproperties
{
    m_eTargetSelectionTypeOverride=TargetSelectionType.TGTST_Random
    m_bIsAOE=true
    m_bIgnoreDeployablesForBlocking=true
}
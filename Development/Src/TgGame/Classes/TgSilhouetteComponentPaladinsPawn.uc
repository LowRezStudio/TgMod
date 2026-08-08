class TgSilhouetteComponentPaladinsPawn extends TgSilhouetteComponentPaladins
    native(FX)
    hidecategories(Object)
    config(Engine);

defaultproperties
{
    m_ColorSettings=(bUsesMultipleColors=true,bUsesEnemyRangeColorVariance=true)
    m_FadeSettings=(bUsesDistanceFade=true)
    m_PulseSettings=(bUsesPulse=true,bPulseMaintainsDistanceDimming=true)
    ReplacementPrimitive=none
}

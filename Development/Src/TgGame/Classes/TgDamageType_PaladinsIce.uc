class TgDamageType_PaladinsIce extends TgDamageType
    config(Engine);

defaultproperties
{
    m_bMinImpulse=1300.0000000
    m_bMaxImpulse=1300.0000000
    m_bMinUpKick=500.0000000
    m_bMaxUpKick=500.0000000
    m_fMinAngularVelocity=-30.0000000
    m_fMaxAngularVelocity=30.0000000
    m_TakeHitAkEvent=AkEvent'PC_Shared_DamageAlert_PaladinsIce_Play'
    m_LatentDamageType=Class'TgDamageType_PaladinsIce_Latent'
}

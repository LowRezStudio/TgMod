class TgDamageType_PaladinsExplosive extends TgDamageType
    config(Engine);

defaultproperties
{
    m_bMinImpulse=1600.0000000
    m_bMaxImpulse=1600.0000000
    m_bMinUpKick=400.0000000
    m_bMaxUpKick=400.0000000
    m_fMinAngularVelocity=-30.0000000
    m_fMaxAngularVelocity=30.0000000
    m_TakeHitAkEvent=AkEvent'PC_Shared_DamageAlert_PaladinsExplosives_Play'
    m_LatentDamageType=Class'TgDamageType_PaladinsExplosive_Latent'
}

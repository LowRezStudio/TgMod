class TgDamageType_PaladinsFire extends TgDamageType
    config(Engine);

defaultproperties
{
    m_bMinImpulse=900.0000000
    m_bMaxImpulse=900.0000000
    m_bMinUpKick=350.0000000
    m_bMaxUpKick=350.0000000
    m_fMinAngularVelocity=-20.0000000
    m_fMaxAngularVelocity=20.0000000
    m_TakeHitAkEvent=AkEvent'PC_Shared_DamageAlert_PaladinsFire_Play'
    m_LatentDamageType=Class'TgDamageType_PaladinsFire_Latent'
}

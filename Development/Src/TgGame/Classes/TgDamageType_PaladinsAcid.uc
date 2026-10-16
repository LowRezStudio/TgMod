class TgDamageType_PaladinsAcid extends TgDamageType
    config(Engine);

defaultproperties
{
    m_bMinImpulse=1350.0000000
    m_bMaxImpulse=1350.0000000
    m_bMinUpKick=800.0000000
    m_bMaxUpKick=800.0000000
    m_fMinAngularVelocity=-20.0000000
    m_fMaxAngularVelocity=20.0000000
    m_TakeHitAkEvent=AkEvent'PC_Shared_DamageAlert_PaladinsAcid_Play'
    m_LatentDamageType=Class'TgDamageType_PaladinsAcid_Latent'
}

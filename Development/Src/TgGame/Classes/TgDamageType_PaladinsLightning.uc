class TgDamageType_PaladinsLightning extends TgDamageType
    config(Engine);

defaultproperties
{
    m_bMinImpulse=1125.0000000
    m_bMaxImpulse=1125.0000000
    m_bMinUpKick=500.0000000
    m_bMaxUpKick=500.0000000
    m_fMinAngularVelocity=-25.0000000
    m_fMaxAngularVelocity=25.0000000
    m_TakeHitAkEvent=AkEvent'PC_Shared_DamageAlert_PaladinsLightning_Play'
    m_LatentDamageType=Class'TgDamageType_PaladinsLightning_Latent'
}

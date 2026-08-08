class TgDamageType_PaladinsSniper extends TgDamageType
    native
    config(Engine);

defaultproperties
{
    m_bMinImpulse=1600.0000000
    m_bMaxImpulse=1600.0000000
    m_bMinUpKick=500.0000000
    m_bMaxUpKick=500.0000000
    m_fMinAngularVelocity=-10.0000000
    m_fMaxAngularVelocity=10.0000000
    m_TakeHitAkEvent=AkEvent'PC_Shared_DamageAlert_PaladinsSniper_Play'
}

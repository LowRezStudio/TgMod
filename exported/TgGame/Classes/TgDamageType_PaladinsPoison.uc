class TgDamageType_PaladinsPoison extends TgDamageType;

defaultproperties
{
    m_bMinImpulse=450.0000000
    m_bMaxImpulse=450.0000000
    m_bMinUpKick=500.0000000
    m_bMaxUpKick=500.0000000
    m_fMinAngularVelocity=-30.0000000
    m_fMaxAngularVelocity=30.0000000
    m_TakeHitAkEvent=AkEvent'WW_PC_Shared.PC_Shared_DamageAlert_PaladinsPoison_Play'
    m_LatentDamageType=Class'TgGame.TgDamageType_PaladinsPoison_Latent'
}
class TgInvListener_CooledMags extends TgInvListener
    native(ChampOwl)
    config(Engine);

var TgPawn_Owl m_CachedOwlPawn;
var TgDevice m_CachedSidearm;
var TgDevice m_CachedInhand;
var float m_fAmmoFillTime;

defaultproperties
{
    m_fAmmoFillTime=9999999.0000000
}

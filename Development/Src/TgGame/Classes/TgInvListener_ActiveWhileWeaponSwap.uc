class TgInvListener_ActiveWhileWeaponSwap extends TgInvListener
    native(ChampOwl)
    config(Engine);

var TgPawn_Owl m_CachedOwlPawn;
var bool m_bActivateWhileInhandActive;
var bool m_bIsActive;

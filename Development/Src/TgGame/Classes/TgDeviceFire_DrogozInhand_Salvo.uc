class TgDeviceFire_DrogozInhand_Salvo extends TgDeviceFire_DrogozInhand
    native(ChampDrogoz)
    config(Engine);

var TgDevice_DrogozInhand m_CachedDrogozInhand;

native function float GetBonusShieldDamagePerc();  // Export UTgDeviceFire_DrogozInhand_Salvo::execGetBonusShieldDamagePerc(FFrame&, void* const)

simulated event float GetPostHitDelay() { }

simulated function bool HasCachedDrogozInhand() { }

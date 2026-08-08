class TgDeviceFire_HeroicLeap extends TgDeviceFire
    native(ChampBuck)
    config(Engine);

native function bool IgnoreTargetForBlocking(Actor Target);  // Export UTgDeviceFire_HeroicLeap::execIgnoreTargetForBlocking(FFrame&, void* const)

defaultproperties
{
    m_bIgnoreDeployablesForBlocking=true
}

class TgDeviceFire_HeroicLeap extends TgDeviceFire
    native(ChampBuck);

// Export UTgDeviceFire_HeroicLeap::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);

defaultproperties
{
    m_bIgnoreDeployablesForBlocking=true
}
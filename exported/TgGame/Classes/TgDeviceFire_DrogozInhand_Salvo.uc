class TgDeviceFire_DrogozInhand_Salvo extends TgDeviceFire_DrogozInhand
    native(ChampDrogoz);

var TgDevice_DrogozInhand m_CachedDrogozInhand;

// Export UTgDeviceFire_DrogozInhand_Salvo::execGetBonusShieldDamagePerc(FFrame&, void* const)
native function float GetBonusShieldDamagePerc();

simulated event float GetPostHitDelay()
{
    // End:0x68
    if(HasCachedDrogozInhand())
    {
        // End:0x68
        if((int(m_CachedDrogozInhand.CurrentFireMode) == int(1)) && m_CachedDrogozInhand.GetCurrentAmmoAmount() > 1)
        {
            return GetCustomValue2();
        }
    }
    return m_fFirePostHitDelay;
    //return ReturnValue;    
}

simulated function bool HasCachedDrogozInhand()
{
    // End:0x2B
    if(m_CachedDrogozInhand == none)
    {
        m_CachedDrogozInhand = TgDevice_DrogozInhand(m_Owner);
    }
    return m_CachedDrogozInhand != none;
    //return ReturnValue;    
}

class TgDeviceFire_Salvo extends TgDeviceFire;

var TgDevice_DrogozInhand m_CachedDrogozInhand;

simulated event float GetPreHitDelay()
{
    local int shotsToLoad;

    shotsToLoad = 1;
    // End:0x44
    if(HasCachedDrogozInhand())
    {
        shotsToLoad = m_CachedDrogozInhand.GetCurrentAmmoAmount() - 1;
    }
    return m_fFirePreHitDelay * float(shotsToLoad);
    //return ReturnValue;    
}

simulated function bool HasCachedDrogozInhand()
{
    local TgPawn PawnOwner;

    // End:0x93
    if((m_CachedDrogozInhand == none) && m_Owner != none)
    {
        PawnOwner = TgPawn(m_Owner.Owner);
        // End:0x93
        if(PawnOwner != none)
        {
            m_CachedDrogozInhand = TgDevice_DrogozInhand(PawnOwner.GetDeviceByEqPoint(1));
        }
    }
    return m_CachedDrogozInhand != none;
    //return ReturnValue;    
}

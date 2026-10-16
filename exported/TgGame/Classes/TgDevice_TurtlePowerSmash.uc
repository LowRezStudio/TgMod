class TgDevice_TurtlePowerSmash extends TgDevice
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

simulated event OnLinkDevice(TgPawn TgP)
{
    local TgPawn_Makoa makoaOwner;

    super.OnLinkDevice(TgP);
    makoaOwner = TgPawn_Makoa(TgP);
    // End:0xAA
    if(((makoaOwner != none) && !makoaOwner.bDeleteMe) && !makoaOwner.bPendingDelete)
    {
        makoaOwner.m_AncientRageInHand = self;
    }
    //return;    
}

simulated event OnUnlinkDevice(TgPawn TgP)
{
    local TgPawn_Makoa makoaOwner;

    super.OnUnlinkDevice(TgP);
    makoaOwner = TgPawn_Makoa(TgP);
    // End:0xD0
    if((((makoaOwner != none) && !makoaOwner.bDeleteMe) && !makoaOwner.bPendingDelete) && makoaOwner.m_AncientRageInHand == self)
    {
        makoaOwner.m_AncientRageInHand = none;
    }
    //return;    
}

simulated event bool PlayHitReactionOverride()
{
    return true;
    //return ReturnValue;    
}

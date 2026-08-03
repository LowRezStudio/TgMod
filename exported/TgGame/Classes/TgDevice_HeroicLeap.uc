class TgDevice_HeroicLeap extends TgDevice_Leap
    hidecategories(Navigation);

simulated function SetLeapParams(out float scaleLateral, out float scaleVertical, out float additiveLateral, out float additiveVertical)
{
    local TgPawn TgPOwner;
    local TgDevice_LegDay DevLegDay;
    local int I;

    super.SetLeapParams(scaleLateral, scaleVertical, additiveLateral, additiveVertical);
    TgPOwner = TgPawn(Instigator);
    // End:0x5B
    if(TgPOwner == none)
    {
        return;
    }
    I = 0;
    J0x66:

    // End:0x114 [Loop If]
    if(I < 33)
    {
        DevLegDay = TgDevice_LegDay(TgPOwner.m_EquippedDevices[I]);
        // End:0x106
        if(DevLegDay != none)
        {
            DevLegDay.ModifyLeapParams(scaleLateral, scaleVertical, additiveLateral, additiveVertical);
            // [Explicit Break]
            goto J0x114;
        }
        I++;
        // [Loop Continue]
        goto J0x66;
    }
    J0x114:

    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_bAlwaysStartCooldown=true
    m_bForce3PViewWhileFiring=false
    m_bAbilityRequiresInhandResync=false
}
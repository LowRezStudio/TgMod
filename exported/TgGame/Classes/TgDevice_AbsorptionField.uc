class TgDevice_AbsorptionField extends TgDevice
    native(ChampLazarus)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;

// Export UTgDevice_AbsorptionField::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

// Export UTgDevice_AbsorptionField::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        super.StartFiringLogic();
        FireAmmunition();
        //return;        
    }

    simulated function ReleaseFireHoldInternal()
    {
        local float fPostHitDelay;

        // End:0x44
        if(int(Role) == int(ROLE_Authority))
        {
            GetCurrentFire().RemoveEffectType(Instigator, true, 15173, 0);
        }
        ClearTimer('FireHoldTimer');
        ClearTimer('FireHoldForceReleaseFUBAR');
        m_bFireHoldFull = false;
        // End:0xB0
        if(c_DeviceForm != none)
        {
            c_DeviceForm.FireHoldFull(m_bFireHoldFull);
        }
        fPostHitDelay = GetCachedFiringPostHitDelay();
        // End:0xEE
        if(fPostHitDelay > 0.0000000)
        {
            SetTimer(fPostHitDelay, false, 'FirePostHitDelay');
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        // End:0x2F
        if(r_Deployable != none)
        {
            r_Deployable.DestroyIt();
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bIsFireHoldDevice=true
    m_fDeployZOffset=46.0000000
}
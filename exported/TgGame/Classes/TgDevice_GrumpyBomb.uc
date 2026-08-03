class TgDevice_GrumpyBomb extends TgDevice
    native(ChampBombKing)
    hidecategories(Navigation);

var() float m_fPostTargetingLockInDuration;

// Export UTgDevice_GrumpyBomb::execUsesTargetingMode(FFrame&, void* const)
native function bool UsesTargetingMode();

// Export UTgDevice_GrumpyBomb::execEnterTargetingMode(FFrame&, void* const)
native function EnterTargetingMode();

// Export UTgDevice_GrumpyBomb::execIsTargetingModeReady(FFrame&, void* const)
native function bool IsTargetingModeReady(optional out TgObject.EDeviceFailType failType);

// Export UTgDevice_GrumpyBomb::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(const out ImpactInfo Impact, out float fDamage, int nPropertyId);

// Export UTgDevice_GrumpyBomb::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function bool InterceptRightMousePressed(TgPlayerController TgController)
{
    local TgPawn TgP;

    // End:0x8B
    if(m_bUseCustomCastMode)
    {
        TgP = TgPawn(Instigator);
        // End:0x8B
        if((TgP != none) && TgP.c_CurrentTargetingDevice == self)
        {
            TgController.bPressingRightMouseButton = false;
            PutAway();
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function PutAway()
{
    local TgPawn TgP;
    local WeaponMeshSwapStrategy SwapStrategy;

    TgP = TgPawn(Instigator);
    // End:0xC7
    if((TgP != none) && TgP.c_CurrentTargetingDevice == self)
    {
        // End:0xC7
        if(!IsFiring())
        {
            SwapStrategy.bPlayPutAway = true;
            TgP.SetTargetingDevice(TgP.GetDeviceByEqPoint(1), SwapStrategy);
        }
    }
    //return;    
}

simulated event bool ShouldInterruptReloadOnBeginTargeting()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    // End:0x2E
    if(super.CanBeInterrupted())
    {
        // End:0x29
        if(IsTimerActive('FirePreHitDelay'))
        {
            return false;            
        }
        else
        {
            return true;
        }        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}

simulated function bool CanToggleTargetingOff()
{
    return (m_bCanToggleTargeting && !IsFiring()) && !IsTimerActive('PostTargetingLockIn');
    //return ReturnValue;    
}

simulated function PostTargetingLockIn()
{
    //return;    
}

defaultproperties
{
    m_eCastModeOverride=ECastMode.CM_Instant
    m_bUseCustomCastMode=true
    m_bDisableLagCompensation=true
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_BombKing.DeviceGrumpyBomb'
}
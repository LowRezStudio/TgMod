class TgDevice_OwlStealth extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation);

var TgPawn_Owl m_CachedOwl;
var TgDevice_Roost m_RoostCard;
var bool c_bAlreadyConsumedStealthJuice;

// Export UTgDevice_OwlStealth::execShouldBlockReload(FFrame&, void* const)
native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);

// Export UTgDevice_OwlStealth::execGetStealthJuicePerSec(FFrame&, void* const)
native function float GetStealthJuicePerSec();

simulated event DeviceConsumePowerPool(byte FireModeNum)
{
    return;
    //return;    
}

simulated event bool CanDeviceStartFiringNow(byte FireModeNum, AimData Aim, bool bDebugRelevant, optional out TgObject.EDeviceFailType failType)
{
    // End:0x80
    if(m_CachedOwl != none)
    {
        // End:0x3B
        if(int(m_CachedOwl.r_eIsStealthed) != int(0))
        {
            return false;
        }
        // End:0x80
        if(m_CachedOwl.m_fOwlStealthJuice < GetCurrentFire().GetCustomValue5())
        {
            return false;
        }
    }
    return super.CanDeviceStartFiringNow(FireModeNum, Aim, bDebugRelevant, failType);
    //return ReturnValue;    
}

simulated function ConsumeStealthJuiceOnFire()
{
    // End:0x75
    if((m_CachedOwl != none) && !c_bAlreadyConsumedStealthJuice)
    {
        c_bAlreadyConsumedStealthJuice = true;
        m_CachedOwl.ModifyStealthJuice(int(-GetCurrentFire().GetShotPowerCost(10013)), false);
    }
    //return;    
}

reliable client simulated function ClientConsumeStealthJuiceOnFire(int nAmtModified)
{
    // End:0x54
    if((m_CachedOwl != none) && !c_bAlreadyConsumedStealthJuice)
    {
        c_bAlreadyConsumedStealthJuice = true;
        m_CachedOwl.ClientModifyStealthJuice(nAmtModified);
    }
    //return;    
}

simulated event bool CanFiringBeCanceledByReactivation()
{
    return super.CanFiringBeCanceledByReactivation() && !IsInState('DeviceBuildup');
    //return ReturnValue;    
}

simulated event bool IsFunctionallyToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldCancelStealth()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    super.LinkedDeviceUnequipped(Dev);
    // End:0x35
    if(m_RoostCard == Dev)
    {
        m_RoostCard = none;
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    local TgDevice_Roost roost;

    super.LinkedDeviceEquipped(Dev);
    roost = TgDevice_Roost(Dev);
    // End:0x51
    if(roost != none)
    {
        m_RoostCard = roost;
    }
    //return;    
}

simulated event OnLinkDevice(TgPawn TgP)
{
    m_CachedOwl = TgPawn_Owl(TgP);
    // End:0x8A
    if(m_CachedOwl != none)
    {
        m_CachedOwl.m_fMaxOwlStealthJuice = GetCurrentFire().GetCustomValue1();
        m_CachedOwl.m_CachedOwlStealth = self;
    }
    super.OnLinkDevice(TgP);
    //return;    
}

simulated event OnUnlinkDevice(TgPawn TgP)
{
    m_CachedOwl = none;
    m_CachedOwl.m_CachedOwlStealth = none;
    OnLinkDevice(TgP);
    //return;    
}

simulated state DeviceBuildup
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        c_bAlreadyConsumedStealthJuice = false;
        //return;        
    }
    stop;    
}

state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        // End:0x48
        if((int(Role) == int(ROLE_Authority)) && m_CachedOwl != none)
        {
            m_CachedOwl.ApplyStealthServer(3);
        }
        ConsumeStealthJuiceOnFire();
        super.StartFiringLogic();
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        ClearTimer('FirePostHitDelay');
        //return;        
    }

    simulated function StopFiringLogic()
    {
        // End:0x48
        if((int(Role) == int(ROLE_Authority)) && m_CachedOwl != none)
        {
            m_CachedOwl.ApplyStealthServer(0);
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceTypes[0]=15189
    m_nLinkedDeviceTypes[1]=15188
}
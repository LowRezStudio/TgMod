class TgDevice_Mount extends TgDevice_Toggle
    native(Devices)
    hidecategories(Navigation);

const TG_DOT_GUARD_MOUNTING = false;

var bool m_bForceFireDueToRespawn;
var bool m_bPostureChange;
var bool m_bDismountProtection;
var() float m_fZoomDurationOverride;
var int m_nAutoReloadTransactionID;
var TgDevice m_CachedInhand;
var float m_fAutoMountDismountProtectionDuration;

// Export UTgDevice_Mount::execGetFiringPreHitDelay(FFrame&, void* const)
native function float GetFiringPreHitDelay(optional int nMode = -1);

// Export UTgDevice_Mount::execIsDeviceFiringLockedForUI(FFrame&, void* const)
native function bool IsDeviceFiringLockedForUI();

// Export UTgDevice_Mount::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

// Export UTgDevice_Mount::execRequiresAmmoToFire(FFrame&, void* const)
native function bool RequiresAmmoToFire();

// Export UTgDevice_Mount::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice_Mount::execIsAnyDeviceOverridingDismount(FFrame&, void* const)
native function bool IsAnyDeviceOverridingDismount(int DamageAmt);

simulated function OnOwnerRespawn()
{
    super(TgDevice).OnOwnerRespawn();
    SetAllowMountServerTimer();
    //return;    
}

function SetAllowMountServerTimer()
{
    // End:0x3C
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        SetTimer(5.0000000, false, 'AllowMountServer');
    }
    //return;    
}

function AllowMountServer()
{
    //return;    
}

reliable client simulated function ClientStartMount()
{
    Use();
    //return;    
}

event ServerForceMount()
{
    local TgPawn PawnOwner;

    PawnOwner = TgPawn(Owner);
    // End:0x4B
    if(PawnOwner != none)
    {
        PawnOwner.InterruptAllDevices(true);
    }
    SetAllowMountServerTimer();
    ClientStartMount();
    //return;    
}

function DismountOnDamage(int DamageAmt)
{
    // End:0x33
    if(!IsAnyDeviceOverridingDismount(DamageAmt) && !IsItemShopVolumeBlockingDismounting())
    {
        InterruptFiring();
    }
    //return;    
}

simulated function EndDismountProtection()
{
    m_bDismountProtection = false;
    //return;    
}

simulated event bool CanBeCanceled()
{
    return (IsFiring()) && !IsItemShopVolumeBlockingDismounting();
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByReactivation()
{
    return (CanBeCanceled()) && !m_bDismountProtection;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return (IsFiring()) && !IsItemShopVolumeBlockingDismounting();
    //return ReturnValue;    
}

simulated function bool IsItemShopVolumeBlockingDismounting()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x2D
    if(TgP == none)
    {
        return false;
    }
    return TgP.IsInItemShop();
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByRightMouse()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return false;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    EndEnteringMount();
    super.FireAmmunition();
    //return;    
}

simulated function OnStartFireRequestSent()
{
    local TgDeviceFire InhandFireMode;

    m_nAutoReloadTransactionID = 0;
    // End:0xFB
    if((m_CachedInhand != none) && m_CachedInhand.RequiresAmmoToFire())
    {
        InhandFireMode = m_CachedInhand.GetCurrentFire();
        // End:0xFB
        if(InhandFireMode != none)
        {
            m_nAutoReloadTransactionID = m_CachedInhand.SetAmmoDelayedWithValidation(m_CachedInhand.r_nMaxAmmoClipCount, InhandFireMode.m_fAmmoClipPreReloadTime + InhandFireMode.m_fAmmoClipPostReloadTime);
        }
    }
    super(TgDevice).OnStartFireRequestSent();
    //return;    
}

simulated function OnInterruptEvent()
{
    // End:0x53
    if((m_nAutoReloadTransactionID != 0) && m_CachedInhand != none)
    {
        m_CachedInhand.CancelSetAmmoDelayed(m_nAutoReloadTransactionID);
        m_nAutoReloadTransactionID = 0;
    }
    super(TgDevice).OnInterruptEvent();
    //return;    
}

simulated function bool IsOwnerOnGround()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    return (TgP == none) || int(TgP.Physics) == int(1);
    //return ReturnValue;    
}

function AuthStartCooldown(optional int nMode = -1, optional float fCooldownTimeOverride = -1.0000000)
{
    // End:0x6F
    if(!TgRepInfo_Game(WorldInfo.GRI).AllowPlayerMounting())
    {
        super(TgDevice).AuthStartCooldown(nMode, 0.0000000);        
    }
    else
    {
        super(TgDevice).AuthStartCooldown(nMode, fCooldownTimeOverride);
    }
    //return;    
}

simulated function AutoDismount()
{
    // End:0x17
    if(IsFiring())
    {
        InterruptFiring();
    }
    //return;    
}

simulated function OutroLockoutTime()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x4F
    if(TgP != none)
    {
        TgP.m_fZoomDurationOverride = 0.0000000;
    }
    //return;    
}

simulated function SetMountedCollision(bool IsActive)
{
    local TgPawn_Character OwningCharacter;

    OwningCharacter = TgPawn_Character(Instigator);
    // End:0x54
    if(OwningCharacter != none)
    {
        OwningCharacter.SetMountedCollision(IsActive);
    }
    //return;    
}

simulated function EndEnteringMount(optional bool bEndingFireLoop)
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x4D
    if(TgP != none)
    {
        TgP.m_bIsEnteringMount = false;
    }
    //return;    
}

simulated function InterruptOtherDevices(TgPawn TgP)
{
    local TgDevice Dev;
    local int I;

    super(TgDevice).InterruptOtherDevices(TgP);
    // End:0xE3
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0xE3
        if(TgP != none)
        {
            I = 1;
            J0x41:

            // End:0xE3 [Loop If]
            if(I < 33)
            {
                Dev = TgP.m_EquippedDevices[I];
                // End:0xD5
                if((Dev != none) && Dev.ShouldMountCancelFiring())
                {
                    Dev.InterruptFiring();
                }
                I++;
                // [Loop Continue]
                goto J0x41;
            }
        }
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    local float firePreHitTime;

    // End:0x4A
    if(IsTimerActive('FirePreHitDelay'))
    {
        firePreHitTime = GetTimerCount('FirePreHitDelay');
        // End:0x4A
        if(firePreHitTime < 0.5000000)
        {
            return true;
        }
    }
    // End:0x94
    if(((Current != none) && Current.m_nDeviceType == 10828) && IsFiring())
    {
        return true;
    }
    // End:0xAD
    if(IsTimerActive('OutroLockoutTime'))
    {
        return true;
    }
    return super(TgDevice).ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super(TgDevice).LinkedDeviceEquipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0x6A
        case 10828:
            m_CachedInhand = Dev;
            // End:0x6D
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated state DeviceBuildup
{
    simulated function BeginState(name PreviousStateName)
    {
        // End:0x20
        if(IsOwnerOnGround())
        {
            super.BeginState(PreviousStateName);
        }
        //return;        
    }

    simulated function Tick(float DeltaSeconds)
    {
        // End:0x20
        if(IsOwnerOnGround())
        {
            BeginState('Active');
        }
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PrevStateName)
    {
        local TgPawn TgP;
        local bool bAllowPlayerMounting;

        bAllowPlayerMounting = TgRepInfo_Game(WorldInfo.GRI).AllowPlayerMounting();
        // End:0x63
        if(!bAllowPlayerMounting)
        {
            m_bForceFireDueToRespawn = true;
        }
        TgP = TgPawn(Instigator);
        // End:0xEB
        if(TgP != none)
        {
            TgP.r_bUseMountPosture = m_bPostureChange;
            TgP.OnMountBegin(m_bForceFireDueToRespawn, m_bPostureChange);
        }
        SetMountedCollision(true);
        InterruptOtherDevices(TgP);
        m_bDismountProtection = true;
        // End:0x13C
        if(m_bForceFireDueToRespawn)
        {
            SetTimer(m_fAutoMountDismountProtectionDuration, false, 'EndDismountProtection');            
        }
        else
        {
            SetTimer(0.5000000, false, 'EndDismountProtection');
        }
        super.BeginState(PrevStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPlayerController TgPC;
        local TgAIController TgAIC;
        local TgPawn TgP;

        super.EndState(NextStateName);
        TgPC = TgPlayerController(Instigator.Controller);
        // End:0x74
        if(TgPC != none)
        {
            TgPC.bRun = 0;
        }
        TgP = TgPawn(Instigator);
        // End:0x175
        if(TgP != none)
        {
            EndEnteringMount(true);
            TgP.StopMountingEffects(true, m_bPostureChange);
            TgP.OnDismount();
            TgAIC = TgAIController(Instigator.Controller);
            // End:0x175
            if(TgAIC != none)
            {
                TgP.r_bIsMounted = false;
                TgP.bNetDirty = true;
            }
        }
        // End:0x1AC
        if(TgP != none)
        {
            TgP.m_fZoomDurationOverride = m_fZoomDurationOverride;
        }
        m_bForceFireDueToRespawn = false;
        SetMountedCollision(false);
        ClearTimer('EndDismountProtection');
        m_bDismountProtection = false;
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bPostureChange=true
    m_fZoomDurationOverride=0.1000000
    m_fAutoMountDismountProtectionDuration=2.0000000
    m_bAlwaysStartCooldown=true
    m_bMustBeOnGroundToFire=true
    m_bUsesOutroLockout=true
    m_nLinkedDeviceTypes[0]=10828
    m_fOutroLockoutTime=0.3000000
}
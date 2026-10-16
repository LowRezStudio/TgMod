class TgDevice_DimensionalLink extends TgDevice
    native(ChampYing)
    hidecategories(Navigation);

struct native DLTeleportTargets
{
    var Vector TargetPosition;
    var Rotator TargetRotation;
    var Actor TargetIllusion;

    structdefaultproperties
    {
        TargetPosition=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        TargetRotation=(Pitch=0,Yaw=0,Roll=0)
        TargetIllusion=none
    }
};

struct native DLDeadTeleportTargets
{
    var Vector TargetPosition;
    var Rotator TargetRotation;
    var float ValidTimeRemaining;

    structdefaultproperties
    {
        TargetPosition=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        TargetRotation=(Pitch=0,Yaw=0,Roll=0)
        ValidTimeRemaining=0.0000000
    }
};

struct native DLRewindTargets
{
    var Vector RewindPosition;
    var Rotator RewindRotation;

    structdefaultproperties
    {
        RewindPosition=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        RewindRotation=(Pitch=0,Yaw=0,Roll=0)
    }
};

var TgPawn_Ying m_CachedYingPawn;
var Actor s_CycleTargets[10];
var int s_nNumCycleTargets;
var int s_nCurrentCycleTargetIndex;
var array<DLTeleportTargets> m_TeleportTargets;
var array<DLDeadTeleportTargets> m_DeadTeleportTargets;
var DLRewindTargets m_RewindTargets[30];
var int m_CurrentRewindIndex;
var int m_ValidRewindIndex1;
var int m_ValidRewindIndex2;
var int m_nNumPrevRewindsToCheck;
var float m_fRewindMinTargetDist;
var float m_fRewindMinNextPointDist;
var float m_fLastRewindTimestamp;
var bool m_bRequiresReset;
var bool m_bSwappingPeriodEnded;
var Actor r_nCurrentCycleTarget;
var TgDevice_Rewind m_CachedCardRewind;
//var delegate<PawnEvent> __PawnEvent__Delegate;

replication
{
    // Pos:0x000
    if(bNetDirty && int(Role) == int(ROLE_Authority))
        r_nCurrentCycleTarget;
}

// Export UTgDevice_DimensionalLink::execValidateReceivedAim(FFrame&, void* const)
native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);

// Export UTgDevice_DimensionalLink::execTickTargetingMode(FFrame&, void* const)
native function TickTargetingMode(float DeltaSeconds);

// Export UTgDevice_DimensionalLink::execIsTargetingModeReady(FFrame&, void* const)
native function bool IsTargetingModeReady(optional out TgObject.EDeviceFailType failType);

// Export UTgDevice_DimensionalLink::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_DimensionalLink::execUsesCachedAim(FFrame&, void* const)
native function bool UsesCachedAim();

// Export UTgDevice_DimensionalLink::execHasCachedYingPawn(FFrame&, void* const)
native function bool HasCachedYingPawn();

// Export UTgDevice_DimensionalLink::execCreateTeleportTargetDeployable(FFrame&, void* const)
native function Actor CreateTeleportTargetDeployable(Vector TargetLocation, Rotator TargetRotation);

// Export UTgDevice_DimensionalLink::execGenerateCycleTargets(FFrame&, void* const)
native function GenerateCycleTargets();

simulated function FireAmmunition()
{
    // End:0x2F
    if(m_CachedCardRewind != none)
    {
        m_CachedCardRewind.DoRewindCardLogic(self);
    }
    super.FireAmmunition();
    //return;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return m_bSwappingPeriodEnded;
    //return ReturnValue;    
}

delegate PawnEvent(TgPawn DeadPawn)
{
    //return;    
}

function IllusionDied(Actor illusion)
{
    local int I;

    // End:0x167
    if(!m_bSwappingPeriodEnded && illusion != none)
    {
        I = 0;
        J0x2B:

        // End:0x167 [Loop If]
        if(I < s_nNumCycleTargets)
        {
            // End:0x159
            if(s_CycleTargets[I] == illusion)
            {
                s_CycleTargets[I] = CreateTeleportTargetDeployable(illusion.Location, illusion.Rotation);
                // End:0xFD
                if(r_nCurrentCycleTarget == illusion)
                {
                    r_nCurrentCycleTarget = s_CycleTargets[I];
                    bNetDirty = true;
                }
                // End:0x157
                if(m_CachedAim.HitActor == illusion)
                {
                    m_CachedAim.HitActor = s_CycleTargets[I];
                }
                return;
            }
            I++;
            // [Loop Continue]
            goto J0x2B;
        }
    }
    //return;    
}

simulated function EndSwappingPeriod()
{
    local int I;

    s_nNumCycleTargets = 0;
    s_nCurrentCycleTargetIndex = 0;
    r_nCurrentCycleTarget = none;
    bNetDirty = true;
    m_bSwappingPeriodEnded = true;
    // End:0x13D
    if(!IsFiring())
    {
        // End:0x122
        if(int(Role) == int(ROLE_Authority))
        {
            I = 0;
            J0x67:

            // End:0x122 [Loop If]
            if(I < 10)
            {
                // End:0x114
                if((s_CycleTargets[I] != none) && EqualEqual_InterfaceInterface(TgInterface_YingIllusion(s_CycleTargets[I]), TgInterface_YingIllusion(none)))
                {
                    // End:0x114
                    if(s_CycleTargets[I].IsA('TgPawn_Illusion'))
                    {
                        s_CycleTargets[I].Destroy();
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x67;
            }
        }
        // End:0x13D
        if(!m_bRequiresReset)
        {
            StartCooldown();
        }
    }
    //return;    
}

simulated function IsFullyReset()
{
    m_bRequiresReset = false;
    //return;    
}

function SetRequiresReset()
{
    m_bRequiresReset = true;
    ClearTimer('EndSwappingPeriod');
    // End:0x37
    if(IsFiring())
    {
        InterruptFiring();
    }
    EndSwappingPeriod();
    ClientSetRequiresReset();
    //return;    
}

reliable client simulated function ClientSetRequiresReset()
{
    ClearTimer('EndSwappingPeriod');
    EndSwappingPeriod();
    m_bRequiresReset = true;
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x54
        case 13414:
        // End:0x5C
        case 14041:
        // End:0x64
        case 14042:
        // End:0x8B
        case 14043:
            m_CachedCardRewind = TgDevice_Rewind(Dev);
            // End:0x8E
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local int I;
        local TgInterface_YingIllusion illusion;

        // End:0x22A
        if(m_bSwappingPeriodEnded && !IsTimerActive('EndSwappingPeriod'))
        {
            // End:0x1D6
            if(int(Role) == int(ROLE_Authority))
            {
                GenerateCycleTargets();
                // End:0xFB
                if(s_CycleTargets[0] != none)
                {
                    m_CachedAim.HitActor = s_CycleTargets[0];
                    m_CachedAim.EndTrace = s_CycleTargets[0].Location;
                    m_CachedAim.AimVector = Vector(s_CycleTargets[0].Rotation);
                }
                s_nCurrentCycleTargetIndex = 1;
                r_nCurrentCycleTarget = s_CycleTargets[s_nCurrentCycleTargetIndex];
                bNetDirty = true;
                I = 0;
                J0x13A:

                // End:0x1D6 [Loop If]
                if(I < s_nNumCycleTargets)
                {
                    illusion = TgInterface_YingIllusion(s_CycleTargets[I]);
                    // End:0x1C8
                    if(NotEqual_InterfaceInterface(illusion, TgInterface_YingIllusion(none)))
                    {
                        illusion.AddOnDestroyDelegate(IllusionDied);
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x13A;
                }
            }
            m_bSwappingPeriodEnded = false;
            SetTimer((((GetCurrentFire()) != none) ? GetCurrentFire().GetPersistTime() : 4.0000000), false, 'EndSwappingPeriod');            
        }
        else
        {
            // End:0x288
            if(int(Role) == int(ROLE_Authority))
            {
                s_nCurrentCycleTargetIndex = (s_nCurrentCycleTargetIndex + 1) % s_nNumCycleTargets;
                r_nCurrentCycleTarget = s_CycleTargets[s_nCurrentCycleTargetIndex];
                bNetDirty = true;
            }
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local int I;

        super.StopFiringLogic();
        // End:0xF3
        if(m_bSwappingPeriodEnded && int(Role) == int(ROLE_Authority))
        {
            I = 0;
            J0x38:

            // End:0xF3 [Loop If]
            if(I < 10)
            {
                // End:0xE5
                if((s_CycleTargets[I] != none) && EqualEqual_InterfaceInterface(TgInterface_YingIllusion(s_CycleTargets[I]), TgInterface_YingIllusion(none)))
                {
                    // End:0xE5
                    if(s_CycleTargets[I].IsA('TgPawn_Illusion'))
                    {
                        s_CycleTargets[I].Destroy();
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x38;
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nNumPrevRewindsToCheck=10
    m_fRewindMinTargetDist=313600.0000000
    m_fRewindMinNextPointDist=6400.0000000
    m_fLastRewindTimestamp=-100.0000000
    m_bRequiresReset=true
    m_bSwappingPeriodEnded=true
    m_bDisableLagCompensation=true
    m_nLinkedDeviceIDs[0]=13414
    m_nLinkedDeviceIDs[1]=14041
    m_nLinkedDeviceIDs[2]=14042
    m_nLinkedDeviceIDs[3]=14043
}
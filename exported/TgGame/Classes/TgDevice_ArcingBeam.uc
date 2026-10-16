class TgDevice_ArcingBeam extends TgDevice
    native(Devices)
    hidecategories(Navigation);

struct native ArcingInfo
{
    var float ArcTime;
    var float RemainingArcTime;
    var int JumpsRemaining;
    var Actor PreviousArcTarget;
    var init array<init Actor> PreviousTargets;
    var TgDeviceFire ArcFiremode;

    structdefaultproperties
    {
        ArcTime=0.0000000
        RemainingArcTime=0.0000000
        JumpsRemaining=0
        PreviousArcTarget=none
        PreviousTargets=none
        ArcFiremode=none
    }
};

struct native PotentialTargetInfo
{
    var Actor Target;
    var int NumHits;
    var float Dist;

    structdefaultproperties
    {
        Target=none
        NumHits=0
        Dist=0.0000000
    }
};

var array<ArcingInfo> m_ArcingList;
var int m_nMaxNumArcsPerTarget;
var bool m_bCanTargetShields;
var bool m_bIsArcing;

// Export UTgDevice_ArcingBeam::execDetermineNextTarget(FFrame&, void* const)
native function Actor DetermineNextTarget(int Index);

// Export UTgDevice_ArcingBeam::execIsValidArcTarget(FFrame&, void* const)
native function bool IsValidArcTarget(Actor TestActor, ArcingInfo Info);

function TriggerArcsInArcingList(float DeltaTime)
{
    local int I;
    local bool bTriggeredArc;

    J0x00:
    bTriggeredArc = false;
    I = 0;
    J0x17:

    // End:0xC0 [Loop If]
    if(I < m_ArcingList.Length)
    {
        m_ArcingList[I].RemainingArcTime -= DeltaTime;
        // End:0xB2
        if(m_ArcingList[I].RemainingArcTime <= 0.0000000)
        {
            bTriggeredArc = true;
            TriggerArc(I);
            // [Explicit Break]
            goto J0xC0;
        }
        I++;
        // [Loop Continue]
        goto J0x17;
    }
    J0xC0:

    // End:0x00
    if(!(!bTriggeredArc))
        goto J0x00;
    //return;    
}

simulated function Tick(float DeltaTime)
{
    super(Actor).Tick(DeltaTime);
    TriggerArcsInArcingList(DeltaTime);
    //return;    
}

function int GetNumArcJumps(Actor InitialTarget, TgDeviceFire FireMode)
{
    local TgPawn TgP;
    local bool bImmune;

    bImmune = false;
    TgP = TgPawn(InitialTarget);
    // End:0x61
    if(TgP != none)
    {
        bImmune = TgP.IsImmuneToDamage();
    }
    // End:0xA4
    if((FireMode != none) && !bImmune)
    {
        return FireMode.GetNumArcJumps();        
    }
    else
    {
        return 0;
    }
    //return ReturnValue;    
}

event BeginArcing(Actor InitialTarget, TgDeviceFire FireMode)
{
    local ImpactInfo Impact;
    local ArcingInfo NewArcingInfo;

    // End:0x22
    if((InitialTarget == none) || FireMode == none)
    {
        return;
    }
    FireMode.ApplyHitSpecial(InitialTarget);
    NewArcingInfo.ArcFiremode = FireMode;
    // End:0xBD
    if(!IsValidArcTarget(InitialTarget, NewArcingInfo) && !InitialTarget.IsA('TgDeploy_HealingTotem'))
    {
        return;
    }
    // End:0x36E
    if(int(WorldInfo.Role) == int(ROLE_Authority))
    {
        Impact.HitActor = InitialTarget;
        Impact.bDirectHit = false;
        Impact.DeviceModeReference = FireMode;
        Impact.HitLocation = InitialTarget.Location;
        Impact.HitNormal = Normal(Owner.Location - InitialTarget.Location);
        FireMode.ApplyHitSpecial(InitialTarget, Impact, 10693);
        NewArcingInfo.JumpsRemaining = GetNumArcJumps(InitialTarget, FireMode);
        NewArcingInfo.PreviousArcTarget = InitialTarget;
        NewArcingInfo.PreviousTargets.Length = 1;
        NewArcingInfo.PreviousTargets[0] = InitialTarget;
        NewArcingInfo.ArcTime = FireMode.GetPropertyValue(151);
        NewArcingInfo.RemainingArcTime = NewArcingInfo.ArcTime;
        m_ArcingList.AddItem(NewArcingInfo);
        m_bIsArcing = true;
        TriggerArcsInArcingList(0.0000000);
    }
    //return;    
}

function EndArcing(int Index)
{
    // End:0x1A
    if(Index >= m_ArcingList.Length)
    {
        return;
    }
    m_ArcingList[Index].PreviousArcTarget = none;
    m_ArcingList[Index].PreviousTargets.Length = 0;
    m_ArcingList[Index].JumpsRemaining = 0;
    m_ArcingList[Index].ArcFiremode = none;
    m_ArcingList.Remove(Index, 1);
    //return;    
}

function TriggerArc(int Index)
{
    local ImpactInfo Impact;
    local Actor Target;

    // End:0x1A
    if(Index >= m_ArcingList.Length)
    {
        return;
    }
    // End:0xC3
    if(((m_ArcingList[Index].PreviousArcTarget == none) || m_ArcingList[Index].ArcFiremode == none) || m_ArcingList[Index].JumpsRemaining <= 0)
    {
        EndArcing(Index);
        m_bIsArcing = false;
        return;
    }
    Target = DetermineNextTarget(Index);
    // End:0x110
    if(Target == none)
    {
        EndArcing(Index);
        m_bIsArcing = false;
        return;
    }
    Impact.HitActor = Target;
    Impact.bDirectHit = false;
    Impact.DeviceModeReference = m_ArcingList[Index].ArcFiremode;
    Impact.HitLocation = Target.Location;
    Impact.HitNormal = Normal(m_ArcingList[Index].PreviousArcTarget.Location - Target.Location);
    m_ArcingList[Index].ArcFiremode.ApplyHit(Impact, Instigator);
    // End:0x32C
    if(m_ArcingList[Index].PreviousTargets.Find(Target) == -1)
    {
        m_ArcingList[Index].ArcFiremode.ApplyHitSpecial(Target, Impact, 10693);
    }
    TgPawn(Instigator).FlashArcing(r_nDeviceInstanceId, int(CurrentFireMode), Impact.HitActor.Location, m_ArcingList[Index].PreviousArcTarget.Location, m_ArcingList[Index].PreviousArcTarget, int(r_eEquippedAt), m_nSocketIndex, true);
    TgPawn(Instigator).FlashArcing(r_nDeviceInstanceId, int(CurrentFireMode), Impact.HitActor.Location, m_ArcingList[Index].PreviousArcTarget.Location, Impact.HitActor, int(r_eEquippedAt), m_nSocketIndex, false);
    m_ArcingList[Index].PreviousArcTarget = Target;
    m_ArcingList[Index].PreviousTargets.AddItem(Target);
    m_ArcingList[Index].JumpsRemaining--;
    m_ArcingList[Index].RemainingArcTime = m_ArcingList[Index].ArcTime;
    //return;    
}

defaultproperties
{
    m_nMaxNumArcsPerTarget=4
    m_bProcAsIfHandDevice=true
}
class TgDevice_ToggleInhand extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var TgPawn m_CachedTgP;
var float m_fCurrentTransitionPct;
var int m_nProjectilesFired;

simulated function TgPawn GetCachedTgP()
{
    // End:0x1C
    if(m_CachedTgP != none)
    {
        return m_CachedTgP;        
    }
    else
    {
        m_CachedTgP = TgPawn(Instigator);
        return m_CachedTgP;
    }
    //return ReturnValue;    
}

// Export UTgDevice_ToggleInhand::execGetBuildupTime(FFrame&, void* const)
native simulated function float GetBuildupTime();

// Export UTgDevice_ToggleInhand::execGetFiringPreHitDelay(FFrame&, void* const)
native simulated function float GetFiringPreHitDelay(optional int nMode = -1);

// Export UTgDevice_ToggleInhand::execGetFiringPostHitDelay(FFrame&, void* const)
native simulated function float GetFiringPostHitDelay(optional int nMode = -1);

simulated function float GetBaseBuildupTime()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x42
    if(FireMode != none)
    {
        return FireMode.m_fBuildupTime;
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

simulated function bool CanToggleDeviceStopFiring()
{
    return m_nProjectilesFired > 0;
    //return ReturnValue;    
}

simulated event bool IsToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    super.FireAmmunition();
    m_nProjectilesFired++;
    //return;    
}

simulated function StartIntroTimer(float fDuration)
{
    local TgPawn TgP;

    ClearTimer('OutroTimer');
    SetTimer(fDuration, false, 'IntroTimer');
    // End:0x6C
    if(c_DeviceForm != none)
    {
        c_DeviceForm.PlayToggleTransitionAnimations(m_fCurrentTransitionPct, fDuration, true);
    }
    TgP = GetCachedTgP();
    // End:0xD4
    if(TgP != none)
    {
        TgP.FlashTransitionIn(r_nDeviceInstanceId, int(CurrentFireMode), m_fCurrentTransitionPct, fDuration);
    }
    //return;    
}

simulated function StartOutroTimer(float fDuration)
{
    local TgPawn TgP;

    ClearTimer('IntroTimer');
    SetTimer(fDuration, false, 'OutroTimer');
    // End:0x6C
    if(c_DeviceForm != none)
    {
        c_DeviceForm.PlayToggleTransitionAnimations(m_fCurrentTransitionPct, fDuration, false);
    }
    TgP = GetCachedTgP();
    // End:0xD4
    if(TgP != none)
    {
        TgP.FlashTransitionOut(r_nDeviceInstanceId, int(CurrentFireMode), m_fCurrentTransitionPct, fDuration);
    }
    //return;    
}

simulated function IntroTimer()
{
    // End:0x2F
    if(c_DeviceForm != none)
    {
        c_DeviceForm.SetToggleState(true);
    }
    //return;    
}

simulated function OutroTimer()
{
    // End:0x2F
    if(c_DeviceForm != none)
    {
        c_DeviceForm.SetToggleState(false);
    }
    //return;    
}

simulated function InitialFirePreHitDelay()
{
    //return;    
}

reliable server event InterruptFiring()
{
    UpdateTransitionPct(1.0000000);
    super.InterruptFiring();
    //return;    
}

reliable client simulated event ClientInterrupt()
{
    UpdateTransitionPct(1.0000000);
    super.ClientInterrupt();
    //return;    
}

simulated function StopFire()
{
    UpdateTransitionPct(1.0000000);
    super.StopFire();
    //return;    
}

simulated event UpdateTransitionPct(optional float fDefaultPct = 0.0000000)
{
    local float timerRate, timerCount, BuildupTime;

    BuildupTime = GetBaseBuildupTime();
    // End:0x14B
    if(BuildupTime > 0.0000000)
    {
        timerRate = GetTimerRate('OutroTimer');
        // End:0xC1
        if(timerRate > float(0))
        {
            timerCount = GetTimerCount('OutroTimer');
            m_fCurrentTransitionPct = 1.0000000 - ((1.0000000 - (timerRate / BuildupTime)) + (timerCount / BuildupTime));
            return;
        }
        timerRate = GetTimerRate('IntroTimer');
        // End:0x14B
        if(timerRate > float(0))
        {
            timerCount = GetTimerCount('IntroTimer');
            m_fCurrentTransitionPct = (1.0000000 - (timerRate / BuildupTime)) + (timerCount / BuildupTime);
            return;
        }
    }
    m_fCurrentTransitionPct = fDefaultPct;
    //return;    
}

simulated state DeviceBuildup
{
    simulated function BeginState(name PreviousStateName)
    {
        local float fBuildupTime;

        fBuildupTime = GetBuildupTime();
        // End:0x3A
        if(fBuildupTime > 0.0000000)
        {
            StartIntroTimer(fBuildupTime);
        }
        m_nProjectilesFired = 0;
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local float timerCount;

        // End:0x91
        if(NextStateName != 'DeviceFiring')
        {
            timerCount = ((GetBaseBuildupTime()) - GetTimerRate('IntroTimer')) + GetTimerCount('IntroTimer');
            // End:0x7E
            if(timerCount > float(0))
            {
                StartOutroTimer(timerCount);                
            }
            else
            {
                StartOutroTimer(timerCount);
            }
        }
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        super.StartFiringLogic();
        ClearTimer('InitialFirePreHitDelay');
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local float fPostHitRate, fPostHitCount, fPreHitRate, fPreHitCount, fNewPreHit;

        fNewPreHit = 0.0000000;
        fPostHitRate = GetTimerRate('FirePostHitDelay');
        fPostHitCount = GetTimerCount('FirePostHitDelay');
        // End:0x91
        if(fPostHitRate > 0.0000000)
        {
            fNewPreHit += (fPostHitRate - fPostHitCount);
            ClearTimer('FirePostHitDelay');
        }
        fPreHitRate = GetTimerRate('FirePreHitDelay');
        fPreHitCount = GetTimerCount('FirePreHitDelay');
        // End:0x113
        if(fPreHitRate > 0.0000000)
        {
            fNewPreHit += (fPreHitRate - fPreHitCount);
            ClearTimer('FirePreHitDelay');
        }
        // End:0x14A
        if(fNewPreHit > 0.0000000)
        {
            self.SetTimer(fNewPreHit, false, 'InitialFirePreHitDelay');
        }
        StartOutroTimer(GetBaseBuildupTime());
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

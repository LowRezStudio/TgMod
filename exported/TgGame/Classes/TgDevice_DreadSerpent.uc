class TgDevice_DreadSerpent extends TgDevice
    hidecategories(Navigation);

var bool s_bQueueVoodooDeploy;

simulated function bool TryDeployVoodoo()
{
    local int I;
    local bool bSuccessfulDeploy;

    // End:0x11
    if(!IsFiring())
    {
        return false;
    }
    I = 0;
    J0x1C:

    // End:0x125 [Loop If]
    if(I < m_FiredProjectiles.Length)
    {
        // End:0x117
        if(((m_FiredProjectiles[I] != none) && !m_FiredProjectiles[I].m_bHasExploded) && !m_FiredProjectiles[I].m_bIsShutDown)
        {
            m_FiredProjectiles[I].Explode(m_FiredProjectiles[I].Location, vect(0.0000000, 0.0000000, 1.0000000));
            bSuccessfulDeploy = true;
        }
        I++;
        // [Loop Continue]
        goto J0x1C;
    }
    // End:0x152
    if((int(Role) < int(ROLE_Authority)) && bSuccessfulDeploy)
    {
        ServerDeployVoodoo();
    }
    // End:0x196
    if(bSuccessfulDeploy && IsTimerActive('FirePostHitDelay'))
    {
        ClearTimer('FirePostHitDelay');
        FirePostHitDelay();
    }
    return bSuccessfulDeploy;
    //return ReturnValue;    
}

simulated function UpdateActiveProjectiles(optional TgProjectile Proj)
{
    super.UpdateActiveProjectiles(Proj);
    // End:0x5B
    if((m_FiredProjectiles.Length == 0) && IsTimerActive('FirePostHitDelay'))
    {
        ClearTimer('FirePostHitDelay');
        FirePostHitDelay();
    }
    //return;    
}

reliable server event ServerDeployVoodoo()
{
    // End:0x2A
    if(!TryDeployVoodoo() && IsFiring())
    {
        s_bQueueVoodooDeploy = true;
    }
    //return;    
}

reliable server event InterruptFiring()
{
    TryDeployVoodoo();
    super.InterruptFiring();
    //return;    
}

reliable client simulated event ClientInterrupt()
{
    TryDeployVoodoo();
    super.ClientInterrupt();
    //return;    
}

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController)
{
    // End:0x0F
    if(TryDeployVoodoo())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptSlotPressed(TgPlayerController TgController)
{
    // End:0x0F
    if(TryDeployVoodoo())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function float GetLockoutExtensionTime()
{
    return super.GetLockoutExtensionTime() + GetCurrentFire().GetCustomValue1();
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        s_bQueueVoodooDeploy = false;
        super.StartFiringLogic();
        //return;        
    }

    simulated function Tick(float DeltaTime)
    {
        // End:0x17
        if(s_bQueueVoodooDeploy)
        {
            TryDeployVoodoo();
        }
        super(Actor).Tick(DeltaTime);
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        TryDeployVoodoo();
        super.FirePostHitDelay();
        //return;        
    }
    stop;    
}

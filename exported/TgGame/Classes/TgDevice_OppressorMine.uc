class TgDevice_OppressorMine extends TgDevice
    native(ChampKinessa)
    hidecategories(Navigation);

var array<Actor> m_NewTargetSFXRecentTargets;
var array<float> m_NewTargetSFXTargetTime;
var float m_fMinNewTargetSFXDelay;

reliable client simulated function ClientPlayOppressorMineNewTargetSound(Actor Target)
{
    local TgPawn_Character TgPC;
    local int Index;

    // End:0x11
    if(Target == none)
    {
        return;
    }
    // End:0x83
    if(m_NewTargetSFXRecentTargets.Find(Target) == -1)
    {
        m_NewTargetSFXRecentTargets.AddItem(Target);
        m_NewTargetSFXTargetTime.AddItem(WorldInfo.TimeSeconds - (float(2) * m_fMinNewTargetSFXDelay));
    }
    Index = m_NewTargetSFXRecentTargets.Find(Target);
    // End:0x1A7
    if((Index != -1) && (m_NewTargetSFXTargetTime[Index] + m_fMinNewTargetSFXDelay) <= WorldInfo.TimeSeconds)
    {
        TgPC = TgPawn_Character(Owner);
        // End:0x1A7
        if((TgPC != none) && TgPC.IsAliveAndWell())
        {
            TgPC.FxReactivateGroupSelf('KinessaOppressorMineNewTarget', 0);
            m_NewTargetSFXTargetTime[Index] = WorldInfo.TimeSeconds;
        }
    }
    //return;    
}

event PlayOppressorMineNewTargetSound(Actor Target)
{
    ClientPlayOppressorMineNewTargetSound(Target);
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x18
    if(super.ShouldLockFiring(Current))
    {
        return true;
    }
    // End:0x62
    if(((Current != none) && Current.r_nDeviceId == 13142) && IsFiring())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_fMinNewTargetSFXDelay=3.0000000
    m_vProjectileSpawnOffset=(X=32.0000000,Y=8.0000000,Z=0.0000000)
}
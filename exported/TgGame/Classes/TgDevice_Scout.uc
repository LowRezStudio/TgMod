class TgDevice_Scout extends TgDevice
    native(ChampCassie)
    hidecategories(Navigation);

var TgPawn m_CachedPawnOwner;
var TgRepInfo_TaskForce m_CachedAllyTaskForce;
var TgRepInfo_TaskForce m_CachedEnemyTaskForce;
var array<TgPawn> m_AlliesScouted;
var array<TgPawn> m_EnemiesScouted;

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
}
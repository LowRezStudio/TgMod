class TgDeviceFire_RestoreSoul extends TgDeviceFire
    native(ChampOracle);

var float m_fServerRangeBufferMult;
var float m_fBaseEncroachmentActorRange;

// Export UTgDeviceFire_RestoreSoul::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);

event bool IsAbyssalFuryActive()
{
    return (GetCustomValue1()) > 0.0000000;
    //return ReturnValue;    
}

simulated event float GetPostHitDelay()
{
    return (GetCustomValue2()) + super.GetPostHitDelay();
    //return ReturnValue;    
}

defaultproperties
{
    m_fServerRangeBufferMult=1.2500000
    m_fBaseEncroachmentActorRange=10.0000000
    m_bUseTargetingEncroachmentActor=true
    m_fEncroachmentRayCastVerticalOffset=0.6000000
    m_nTargetingEncroachmentActorOverride=7372
}
class TgDeviceFire_RestoreSoul extends TgDeviceFire
    native(ChampOracle)
    config(Engine);

var float m_fServerRangeBufferMult;
var float m_fBaseEncroachmentActorRange;

native function bool IgnoreTargetForBlocking(Actor Target);  // Export UTgDeviceFire_RestoreSoul::execIgnoreTargetForBlocking(FFrame&, void* const)

event bool IsAbyssalFuryActive() { }

simulated event float GetPostHitDelay() { }

defaultproperties
{
    m_fServerRangeBufferMult=1.2500000
    m_fBaseEncroachmentActorRange=10.0000000
    m_bUseTargetingEncroachmentActor=true
    m_fEncroachmentRayCastVerticalOffset=0.6000000
    m_nTargetingEncroachmentActorOverride=7372
}

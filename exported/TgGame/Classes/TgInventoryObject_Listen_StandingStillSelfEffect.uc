class TgInventoryObject_Listen_StandingStillSelfEffect extends TgInvListener
    native(Inventory);

var float m_fRestTime;
var bool m_bIsApplied;
var TgPawn m_CachedPawnOwner;

defaultproperties
{
    m_fRestTime=1.0000000
}
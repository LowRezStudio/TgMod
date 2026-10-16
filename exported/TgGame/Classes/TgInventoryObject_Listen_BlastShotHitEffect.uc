class TgInventoryObject_Listen_BlastShotHitEffect extends TgInvListener
    native(Inventory);

var array<Actor> m_PreviouslyHitActors;
var const int m_nTargetType;

defaultproperties
{
    m_nTargetType=3
}
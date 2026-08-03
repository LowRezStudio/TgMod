class TgInventoryObject_Listen_InHand_HitMissStacker extends TgInvListener
    native(Inventory);

var float m_fLastStackTime;
var int m_nAppliedStacks;

defaultproperties
{
    m_fLastStackTime=-1.0000000
}
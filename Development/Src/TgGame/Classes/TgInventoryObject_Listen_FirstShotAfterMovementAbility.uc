class TgInventoryObject_Listen_FirstShotAfterMovementAbility extends TgInvListener
    native(Inventory)
    config(Engine);

var float m_fLastMovementAbilityTime;
var bool m_bJustFinishedMovementAbility;
var int m_nNumApplicationsRemaining;
var float m_fLastAppliedTime;

defaultproperties
{
    m_fLastMovementAbilityTime=-10.0000000
}

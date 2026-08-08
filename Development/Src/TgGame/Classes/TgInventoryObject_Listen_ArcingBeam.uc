class TgInventoryObject_Listen_ArcingBeam extends TgInvListener
    native(Inventory)
    config(Engine);

var int m_nDeviceId;
var array<Actor> m_MarkedTargets;

simulated event AddUIMarks(Actor Target, int nNumMarks) { }

simulated event RemoveUIMarks(Actor Target, int nNumMarks) { }

simulated function ExpireUIMarks() { }

function int CountMarksForActor(Actor Actor) { }

defaultproperties
{
    m_nDeviceId=14475
}

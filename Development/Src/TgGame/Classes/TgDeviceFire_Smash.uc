class TgDeviceFire_Smash extends TgDeviceFire
    native(ChampMakoa)
    config(Engine);

var Actor m_NormalTargetingEncroachmentActor;
var Actor m_LargeTargetingEncroachmentActor;
var int m_nLargeTargetingMeshID;

simulated function ToggleTargetingMesh(bool bEnable) { }

defaultproperties
{
    m_nLargeTargetingMeshID=5958
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=5905
}

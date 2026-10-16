class TgDeviceFire_Smash extends TgDeviceFire
    native(ChampMakoa);

var Actor m_NormalTargetingEncroachmentActor;
var Actor m_LargeTargetingEncroachmentActor;
var int m_nLargeTargetingMeshID;

simulated function ToggleTargetingMesh(bool bEnable)
{
    // End:0x23
    if(bEnable)
    {
        m_TargetingEncroachmentActor = m_LargeTargetingEncroachmentActor;        
    }
    else
    {
        m_TargetingEncroachmentActor = m_NormalTargetingEncroachmentActor;
    }
    //return;    
}

defaultproperties
{
    m_nLargeTargetingMeshID=5958
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=5905
}
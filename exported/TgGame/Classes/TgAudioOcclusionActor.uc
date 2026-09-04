class TgAudioOcclusionActor extends Actor
    native(Navigation)
    notplaceable
    hidecategories(Navigation)
    implements(Interface_NavigationHandle);

var private native const noexport Pointer VfTable_IInterface_NavigationHandle;
var Class<NavigationHandle> m_NavigationHandleClass;
var NavigationHandle m_NavigationHandle;
var Vector NavMeshPath_SearchExtent_Modifier;
var transient float m_fCurrentMaxPathLength;

event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x31
    if(m_NavigationHandleClass != none)
    {
        m_NavigationHandle = new (self) m_NavigationHandleClass;
    }
    //return;    
}

// Export UTgAudioOcclusionActor::execCalcOcclusionAmount(FFrame&, void* const)
native function float CalcOcclusionAmount(Actor SourceActor);

event NotifyPathChanged()
{
    //return;    
}

defaultproperties
{
    m_NavigationHandleClass=Class'TgGame.TgHavokNavigationHandleAudio'
    bHidden=true
    bTickIsDisabled=true
    bHardAttach=true
    bUpdateHavokPos=true
}
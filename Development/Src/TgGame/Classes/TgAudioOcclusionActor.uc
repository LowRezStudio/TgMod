class TgAudioOcclusionActor extends Actor
    native(Navigation)
    notplaceable
    hidecategories(Navigation)
    implements(Interface_NavigationHandle)
    config(Engine);

var Class<NavigationHandle> m_NavigationHandleClass;
var NavigationHandle m_NavigationHandle;
var Vector NavMeshPath_SearchExtent_Modifier;
var transient float m_fCurrentMaxPathLength;

event PostBeginPlay() { }

native function float CalcOcclusionAmount(Actor SourceActor);  // Export UTgAudioOcclusionActor::execCalcOcclusionAmount(FFrame&, void* const)

event NotifyPathChanged() { }

defaultproperties
{
    m_NavigationHandleClass=Class'TgHavokNavigationHandleAudio'
    bHidden=true
    bTickIsDisabled=true
    bHardAttach=true
    bUpdateHavokPos=true
}

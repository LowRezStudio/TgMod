class TgPathPreviewActor extends Actor
    native(Navigation)
    placeable
    hidecategories(Navigation)
    implements(Interface_NavigationHandle)
    config(Engine);

var () TgPathPreviewActor m_Destination;
var TgPathPreviewActor m_Source;
var HavokNavigationHandle m_NavigationHandle;
var () editinline NavMeshPathParams m_NavMeshPathParams;

event NotifyPathChanged() { }

defaultproperties
{
    m_NavMeshPathParams=(bCanMantle=false,bNeedsMantleValidityTest=false,bAbleToSearch=true,SearchExtent=(X=50.0000000,Y=50.0000000,Z=100.0000000),SearchLaneMultiplier=0.0000000,SearchStart=(X=0.0000000,Y=0.0000000,Z=0.0000000),MaxDropHeight=500.0000000,MinWalkableZ=0.7000000,MaxHoverDistance=10.0000000,MaxPathLength=0.0000000)
    Components[0]=none
    Components[1]=none
    bUpdateHavokPos=true
}

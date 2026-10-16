class CrowdAgentBase extends Actor
    abstract
    native(AI)
    notplaceable
    hidecategories(Navigation)
    classgroup(Crowd)
    implements(Interface_NavigationHandle);

var private native const noexport Pointer VfTable_IInterface_NavigationHandle;

event NotifyPathChanged()
{
    //return;    
}

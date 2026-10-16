class TgManifestGroup extends Object
    native;

var private native const noexport Pointer VfTable_FCallbackEventDevice;
var init native array<init Pointer> m_ManifestList;
var init array<init TgObjectReferencer> m_pObjectReferencers;
var Object m_OwningObject;
var bool m_bIsInCallback;
var bool m_bInitialized;
var bool m_bResetOnMapLoad;
//var delegate<OnAllManifestsLoaded> __OnAllManifestsLoaded__Delegate;

delegate OnAllManifestsLoaded()
{
    //return;    
}

defaultproperties
{
    m_bResetOnMapLoad=true
}
class TgManifestGroup extends Object
    native
    config(Engine);

var init native array<init Pointer> m_ManifestList;
var init array<init TgObjectReferencer> m_pObjectReferencers;
var Object m_OwningObject;
var bool m_bIsInCallback;
var bool m_bInitialized;
var bool m_bResetOnMapLoad;

delegate OnAllManifestsLoaded();

defaultproperties
{
    m_bResetOnMapLoad=true
}

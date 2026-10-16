class PrefabInstance extends Actor
    native(Prefab)
    notplaceable
    hidecategories(Navigation);

var const Prefab TemplatePrefab;
var const int TemplateVersion;
var native const map{VOID,VOID} ArchetypeToInstanceMap;
var const PrefabSequence SequenceInstance;
var const int PI_PackageVersion;
var const int PI_LicenseePackageVersion;
var const array<byte> PI_Bytes;
var const array<Object> PI_CompleteObjects;
var const array<Object> PI_ReferencedObjects;
var const array<string> PI_SavedNames;
var native const map{VOID,VOID} PI_ObjectMap;
var() editoronly const bool m_bIgnoreVersionUpdates;

defaultproperties
{
    PI_PackageVersion=-1
    PI_LicenseePackageVersion=-1
    Components[0]=none
}
class TgAnimMetaData_MICScalarParameterExtended extends TgAnimMetaData_MICScalarParameter
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

struct AlternateMaterialOverride {
    var () const MaterialInstanceConstant MaterialToFind;
    var () const MaterialInstanceConstant MaterialToReplace;
    structdefaultproperties {}
};

struct SwappedMeshResetInfo {
    var export editinline SkeletalMeshComponent SkelMeshComp;
    var int MaterialIndex;
    var MaterialInstanceConstant OrigMatInst;
    structdefaultproperties {}
};

var (ExtendedOptions) bool bSearchSelf;
var (ExtendedOptions) bool bSearchSiblings;
var (ExtendedOptions) bool bSearchChildren;
var (ExtendedOptions) bool bIncludeSearchParticles;
var (ExtendedOptions) bool bIncludeSearchMeshes;
var (ExtendedOptions) bool bForceAllMaterials;
var (ExtendedOptions) bool bFindAllMatchingMaterials;
var transient bool bHasSetMICs;
var (ExtendedOptions) const MaterialInstanceConstant MaterialToFind;
var (ExtendedOptions) const MaterialInstanceConstant MaterialToReplace;
var (ExtendedOptions) array<AlternateMaterialOverride> AlternateMaterialList;
var (ExtendedOptions) const array<name> TexturesToHarvest;
var transient array<SwappedMeshResetInfo> MaterialsToReset;
var transient array<MaterialInstanceConstant> CurrentModifiedMICs;

defaultproperties
{
    bSearchSelf=true
    bIncludeSearchMeshes=true
    TexturesToHarvest[0]="Normal"
    TexturesToHarvest[1]="Diffuse"
    TexturesToHarvest[2]="Specular"
}

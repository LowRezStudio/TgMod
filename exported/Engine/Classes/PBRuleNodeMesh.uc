class PBRuleNodeMesh extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

struct native BuildingMatOverrides
{
    var() array<MaterialInterface> MaterialOptions;

    structdefaultproperties
    {
        MaterialOptions=none
    }
};

struct native BuildingMeshInfo
{
    var() StaticMesh Mesh;
    var() float DimX;
    var() float DimZ;
    var() float Chance;
    var() export editinline DistributionVector Translation;
    var() export editinline DistributionVector Rotation;
    var() bool bMeshScaleTranslation;
    var() bool bOverrideMeshLightMapRes;
    var() int OverriddenMeshLightMapRes;
    var array<MaterialInterface> MaterialOverrides;
    var() array<BuildingMatOverrides> SectionOverrides;

    structdefaultproperties
    {
        Mesh=none
        DimX=512.0000000
        DimZ=512.0000000
        Chance=1.0000000
        Translation=none
        Rotation=none
        bMeshScaleTranslation=false
        bOverrideMeshLightMapRes=false
        OverriddenMeshLightMapRes=32
        MaterialOverrides=none
        SectionOverrides=none
    }
};

var() array<BuildingMeshInfo> BuildingMeshes;
var() BuildingMeshInfo PartialOccludedBuildingMesh;
var() bool bDoOcclusionTest;
var() bool bBlockAll;

// Export UPBRuleNodeMesh::execPickRandomBuildingMesh(FFrame&, void* const)
native function int PickRandomBuildingMesh();

defaultproperties
{
    PartialOccludedBuildingMesh=(Mesh=none,DimX=512.0000000,DimZ=512.0000000,Chance=1.0000000,Translation=none,Rotation=none,bMeshScaleTranslation=false,bOverrideMeshLightMapRes=false,OverriddenMeshLightMapRes=32,MaterialOverrides=none,SectionOverrides=none)
    bDoOcclusionTest=true
    NextRules=none
}
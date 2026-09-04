class StaticMeshActor extends StaticMeshActorBase
    native
    placeable
    hidecategories(Navigation);

struct native VertexColorPhysicalMaterialMapping
{
    var() PhysicalMaterial PhysMat;
    var() Color MappingColor;

    structdefaultproperties
    {
        PhysMat=none
        MappingColor=(R=0,G=0,B=0,A=0)
    }
};

var() const editconst export editinline StaticMeshComponent StaticMeshComponent;
var() bool bRenderElementsViaProxy;
var() editoronly bool bDisableAutoBaseOnProcBuilding;
var private bool bProxy;
var private bool bHiddenByProxy;
var private bool OldCastShadow;
var private bool OldAcceptsLights;
var(NavMesh) bool bCuttingMesh;
var() export editinline TgSilhouetteComponent Silhouette;
var(PaladinsPhysicalMaterials) array<VertexColorPhysicalMaterialMapping> VertexColorPhysicalMaterialMappings;

event PreBeginPlay()
{
    //return;    
}

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__StaticMeshActor.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    begin object name="StaticMeshComponent0" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        bAllowApproximateOcclusion=true
        bForceDirectLightMap=true
        bUsePrecomputedShadows=true
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: TgSilhouetteComponent'Engine.Default__StaticMeshActor.MySilhouette'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MySilhouette'
    begin object name="MySilhouette" class=Engine.TgSilhouetteComponent
        MeshComponent=StaticMeshComponent'Engine.Default__StaticMeshActor.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=StaticMeshComponent0
    Components[1]=MySilhouette
    CollisionComponent=StaticMeshComponent0
}
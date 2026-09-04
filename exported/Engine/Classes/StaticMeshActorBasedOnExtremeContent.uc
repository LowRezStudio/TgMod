class StaticMeshActorBasedOnExtremeContent extends Actor
    native
    placeable
    hidecategories(Navigation)
    classgroup(StaticMeshes);

struct native SMMaterialSetterDatum
{
    var() int MaterialIndex;
    var() MaterialInterface TheMaterial;

    structdefaultproperties
    {
        MaterialIndex=0
        TheMaterial=none
    }
};

var() const editconst export editinline StaticMeshComponent StaticMeshComponent;
var() array<SMMaterialSetterDatum> ExtremeContent;
var() array<SMMaterialSetterDatum> NonExtremeContent;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    SetMaterialBasedOnExtremeContent();
    //return;    
}

simulated function SetMaterialBasedOnExtremeContent()
{
    local int Idx;

    // End:0xD6
    if(WorldInfo.GRI.ShouldShowGore())
    {
        Idx = 0;
        J0x42:

        // End:0xD3 [Loop If]
        if(Idx < ExtremeContent.Length)
        {
            StaticMeshComponent.SetMaterial(ExtremeContent[Idx].MaterialIndex, ExtremeContent[Idx].TheMaterial);
            ++Idx;
            // [Loop Continue]
            goto J0x42;
        }        
    }
    else
    {
        Idx = 0;
        J0xE1:

        // End:0x172 [Loop If]
        if(Idx < NonExtremeContent.Length)
        {
            StaticMeshComponent.SetMaterial(NonExtremeContent[Idx].MaterialIndex, NonExtremeContent[Idx].TheMaterial);
            ++Idx;
            // [Loop Continue]
            goto J0xE1;
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__StaticMeshActorBasedOnExtremeContent.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    begin object name="StaticMeshComponent0" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        bAllowApproximateOcclusion=true
        bForceDirectLightMap=true
        bUsePrecomputedShadows=true
    end object
    StaticMeshComponent=StaticMeshComponent0
    Components[0]=StaticMeshComponent0
    bStatic=true
    bWorldGeometry=true
    bGameRelevant=true
    bMovable=false
    bCollideActors=true
    bBlockActors=true
    bEdShouldSnap=true
    CollisionComponent=StaticMeshComponent0
}
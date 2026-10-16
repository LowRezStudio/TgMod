class FracturedStaticMeshActor_Spawnable extends FracturedStaticMeshActor
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: FracturedStaticMeshComponent'Engine.Default__FracturedStaticMeshActor_Spawnable.FracturedStaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FracturedStaticMeshComponent0'
    // Archetype: FracturedStaticMeshComponent'Engine.Default__FracturedStaticMeshActor.FracturedStaticMeshComponent0'
    begin object name="FracturedStaticMeshComponent0"
        ReplacementPrimitive=none
    end object
    FracturedStaticMeshComponent=FracturedStaticMeshComponent0
    // Reference: FracturedSkinnedMeshComponent'Engine.Default__FracturedStaticMeshActor_Spawnable.FracturedSkinnedComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FracturedSkinnedComponent0'
    // Archetype: FracturedSkinnedMeshComponent'Engine.Default__FracturedStaticMeshActor.FracturedSkinnedComponent0'
    begin object name="FracturedSkinnedComponent0"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__FracturedStaticMeshActor_Spawnable.LightEnvironment0'
    end object
    SkinnedComponent=FracturedSkinnedComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__FracturedStaticMeshActor_Spawnable.LightEnvironment0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'LightEnvironment0'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__FracturedStaticMeshActor.LightEnvironment0'
    begin object name="LightEnvironment0"
    end object
    Components[0]=LightEnvironment0
    Components[1]=FracturedSkinnedComponent0
    Components[2]=FracturedStaticMeshComponent0
    bNoDelete=false
    CollisionComponent=FracturedStaticMeshComponent0
}
class InterpActor_ForCinematic extends InterpActor
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__InterpActor_ForCinematic.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__InterpActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__InterpActor_ForCinematic.MyLightEnvironment'
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__InterpActor_ForCinematic.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__InterpActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    Components[1]=StaticMeshComponent0
    CollisionComponent=StaticMeshComponent0
}
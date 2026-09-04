class DynamicSMActor_Spawnable extends DynamicSMActor
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__DynamicSMActor_Spawnable.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__DynamicSMActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor_Spawnable.MyLightEnvironment'
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor_Spawnable.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    Components[1]=StaticMeshComponent0
    bCollideActors=true
    bBlockActors=true
    CollisionComponent=StaticMeshComponent0
}
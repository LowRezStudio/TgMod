class ApexDestructibleActorSpawnable extends ApexDestructibleActor
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__ApexDestructibleActorSpawnable.LightEnvironment0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'LightEnvironment0'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__ApexDestructibleActor.LightEnvironment0'
    begin object name="LightEnvironment0"
    end object
    LightEnvironment=LightEnvironment0
    // Reference: ApexStaticDestructibleComponent'Engine.Default__ApexDestructibleActorSpawnable.DestructibleComponent0'
    // Archetype: ApexStaticDestructibleComponent'Engine.Default__ApexDestructibleActor.DestructibleComponent0'
    begin object name="DestructibleComponent0"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__ApexDestructibleActorSpawnable.LightEnvironment0'
    end object
    StaticDestructibleComponent=DestructibleComponent0
    Components[0]=LightEnvironment0
    Components[1]=DestructibleComponent0
    bNoDelete=false
    CollisionComponent=DestructibleComponent0
}
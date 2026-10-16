class TgKActorSpawnable extends KActorSpawnable
    native;

defaultproperties
{
    // Reference: TgStaticMeshComponent'TgGame.Default__TgKActorSpawnable.StaticMeshComp'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComp'
    begin object name="StaticMeshComp" class=TgGame.TgStaticMeshComponent
        WireframeColor=(R=0,G=255,B=128,A=255)
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
        RBCollideWithChannels=(Default=true,GameplayPhysics=true,EffectPhysics=true)
    end object
    StaticMeshComponent=StaticMeshComp
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgKActorSpawnable.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__KActorSpawnable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    // Reference: StaticMeshComponent'TgGame.Default__TgKActorSpawnable.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__KActorSpawnable.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgKActorSpawnable.MyLightEnvironment'
    end object
    Components[1]=StaticMeshComponent0
    Components[2]=StaticMeshComp
    CollisionComponent=StaticMeshComp
}
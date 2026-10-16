class GameKActorSpawnableEffect extends KActor;

simulated event PostBeginPlay()
{
    SetTimer(FMax(0.0100000, LifeSpan - 1.1000000), false, 'StartScalingDown');
    //return;    
}

simulated event FellOutOfWorld(Class<DamageType> dmgType)
{
    Destroy();
    //return;    
}

simulated function StartScalingDown()
{
    GotoState('ScalingDown');
    //return;    
}

simulated state ScalingDown
{
    simulated event Tick(float DeltaTime)
    {
        super(Actor).Tick(DeltaTime);
        // End:0x39
        if(LifeSpan < 1.0000000)
        {
            SetDrawScale(LifeSpan);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    // Reference: StaticMeshComponent'GameFramework.Default__GameKActorSpawnableEffect.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__KActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'GameFramework.Default__GameKActorSpawnableEffect.MyLightEnvironment'
        bAcceptsStaticDecals=false
        bAcceptsDynamicDecals=false
        CastShadow=false
        BlockActors=false
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'GameFramework.Default__GameKActorSpawnableEffect.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__KActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
        bCastShadows=false
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    Components[1]=StaticMeshComponent0
    RemoteRole=ENetRole.ROLE_None
    bNoDelete=false
    bBlocksNavigation=false
    bCollideActors=false
    LifeSpan=30.0000000
    CollisionComponent=StaticMeshComponent0
}
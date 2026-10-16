class KActorSpawnable extends KActor
    native(Physics)
    notplaceable;

var bool bRecycleScaleToZero;
var protected bool bScalingToZero;

simulated function Initialize()
{
    bScalingToZero = false;
    SetDrawScale(default.DrawScale);
    ClearTimer('Recycle');
    SetHidden(false);
    StaticMeshComponent.SetHidden(false);
    SetTickIsDisabled(false);
    SetPhysics(10);
    SetCollision(true, false);
    //return;    
}

simulated function Recycle()
{
    // End:0x1F
    if(bRecycleScaleToZero == true)
    {
        bScalingToZero = true;        
    }
    else
    {
        RecycleInternal();
    }
    //return;    
}

simulated event RecycleInternal()
{
    SetHidden(true);
    StaticMeshComponent.SetHidden(true);
    SetPhysics(0);
    SetCollision(false, false);
    ClearTimer('Recycle');
    SetTickIsDisabled(true);
    //return;    
}

// Export UKActorSpawnable::execResetComponents(FFrame&, void* const)
native final function ResetComponents();

defaultproperties
{
    // Reference: StaticMeshComponent'Engine.Default__KActorSpawnable.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__KActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'Engine.Default__KActorSpawnable.MyLightEnvironment'
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'Engine.Default__KActorSpawnable.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__KActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    Components[1]=StaticMeshComponent0
    bNoDelete=false
    CollisionComponent=StaticMeshComponent0
}
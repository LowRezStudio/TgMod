class InteractiveFoliageActor extends StaticMeshActor
    native(Foliage)
    placeable
    hidecategories(Navigation);

var private export editinline CylinderComponent CylinderComponent;
var private transient Vector TouchingActorEntryPosition;
var private transient Vector FoliageVelocity;
var private transient Vector FoliageForce;
var private transient Vector FoliagePosition;
var(FoliagePhysics) float FoliageDamageImpulseScale;
var(FoliagePhysics) float FoliageTouchImpulseScale;
var(FoliagePhysics) float FoliageStiffness;
var(FoliagePhysics) float FoliageStiffnessQuadratic;
var(FoliagePhysics) float FoliageDamping;
var(FoliagePhysics) float MaxDamageImpulse;
var(FoliagePhysics) float MaxTouchImpulse;
var(FoliagePhysics) float MaxForce;
var float Mass;

// Export UInteractiveFoliageActor::execTakeDamage(FFrame&, void* const)
native simulated event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser);

// Export UInteractiveFoliageActor::execTouch(FFrame&, void* const)
native simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal);

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__InteractiveFoliageActor.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=200.0000000
        CollisionRadius=60.0000000
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    CylinderComponent=CollisionCylinder
    FoliageDamageImpulseScale=20.0000000
    FoliageTouchImpulseScale=10.0000000
    FoliageStiffness=10.0000000
    FoliageStiffnessQuadratic=0.3000000
    FoliageDamping=2.0000000
    MaxDamageImpulse=100000.0000000
    MaxTouchImpulse=1000.0000000
    MaxForce=100000.0000000
    Mass=1.0000000
    // Reference: InteractiveFoliageComponent'Engine.Default__InteractiveFoliageActor.FoliageMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FoliageMeshComponent0'
    begin object name="FoliageMeshComponent0" class=Engine.InteractiveFoliageComponent
        ReplacementPrimitive=none
        bAllowApproximateOcclusion=true
        bAcceptsStaticDecals=false
        bAcceptsDynamicDecals=false
        bForceDirectLightMap=true
        bUsePrecomputedShadows=true
    end object
    StaticMeshComponent=FoliageMeshComponent0
    // Reference: TgSilhouetteComponent'Engine.Default__InteractiveFoliageActor.MySilhouette'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__StaticMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=StaticMeshComponent'Engine.Default__InteractiveFoliageActor.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=MySilhouette
    Components[1]=FoliageMeshComponent0
    Components[2]=CollisionCylinder
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
    bNoDelete=true
    bWorldGeometry=false
    bBlockActors=false
    bProjTarget=true
    CollisionComponent=CollisionCylinder
}
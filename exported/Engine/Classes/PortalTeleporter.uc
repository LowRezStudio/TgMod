class PortalTeleporter extends SceneCapturePortalActor
    abstract
    native
    notplaceable
    hidecategories(Navigation);

var() PortalTeleporter SisterPortal;
var() int TextureResolutionX;
var() int TextureResolutionY;
var PortalMarker MyMarker;
var() bool bMovablePortal;
var bool bAlwaysTeleportNonPawns;
var bool bCanTeleportVehicles;

// Export UPortalTeleporter::execTransformActor(FFrame&, void* const)
native final function bool TransformActor(Actor A);

// Export UPortalTeleporter::execTransformVectorDir(FFrame&, void* const)
native final function Vector TransformVectorDir(Vector V);

// Export UPortalTeleporter::execTransformHitLocation(FFrame&, void* const)
native final function Vector TransformHitLocation(Vector HitLocation);

// Export UPortalTeleporter::execCreatePortalTexture(FFrame&, void* const)
native final function TextureRenderTarget2D CreatePortalTexture();

simulated function bool StopsProjectile(Projectile P)
{
    return !TransformActor(P);
    //return ReturnValue;    
}

defaultproperties
{
    TextureResolutionX=256
    TextureResolutionY=256
    bAlwaysTeleportNonPawns=true
    // Reference: StaticMeshComponent'Engine.Default__PortalTeleporter.StaticMeshComponent2'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent2'
    // Archetype: StaticMeshComponent'Engine.Default__SceneCapturePortalActor.StaticMeshComponent2'
    begin object name="StaticMeshComponent2"
        ReplacementPrimitive=none
        HiddenGame=false
        CollideActors=true
    end object
    StaticMesh=StaticMeshComponent2
    // Reference: SceneCapturePortalComponent'Engine.Default__PortalTeleporter.SceneCapturePortalComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SceneCapturePortalComponent0'
    // Archetype: SceneCapturePortalComponent'Engine.Default__SceneCapturePortalActor.SceneCapturePortalComponent0'
    begin object name="SceneCapturePortalComponent0"
    end object
    SceneCapture=SceneCapturePortalComponent0
    Components[0]=SceneCapturePortalComponent0
    Components[1]=none
    Components[2]=StaticMeshComponent2
    bWorldGeometry=true
    bMovable=false
    bCollideActors=true
    bBlockActors=true
    CollisionComponent=StaticMeshComponent2
}